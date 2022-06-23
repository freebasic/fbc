// This is the program that will run the tests.
//
// Tests mainly consist of capturing the TTY state, running a testee FB program,
// and checking the TTY state again afterwards. Any change in TTY state
// probably indicates an issue with the FB runtime's TTY state clean-up code.
//
// This should not be written in FB itself, otherwise the test could be contaminated. :/

#include <cstring>
#include <inttypes.h>
#include <optional>
#include <sstream>
#include <stdexcept>
#include <stdint.h>
#include <stdio.h>
#include <string>
#include <system_error>

#include <errno.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <termios.h>
#include <unistd.h>

namespace {

#if 0
class fd_wrapper {
	std::string m_description;
	int m_fd;
public:
	fd_wrapper(const std::string &path, int flags, int mode = 0)
		: m_description(path)
		, m_fd(open(path.c_str(), flags, mode))
	{
		if (m_fd < 0) {
			const int e = errno;
			throw std::system_error(e, std::system_category(), "Failed to open \"" + path + "\"");
		}
	}

	~fd_wrapper() {
		close(m_fd);
	}

	// Copying not allowed, due to owned fd (could be implemented with dup(), but not needed)
	fd_wrapper(const fd_wrapper &) = delete;
	fd_wrapper &operator =(const fd_wrapper &) = delete;
};
#endif

std::string dump_tty_state(const struct termios &state) {
	std::ostringstream s;
	s << '\n';
	s << "  c_iflag=0x" << std::hex << state.c_iflag << '\n';
	s << "  c_oflag=0x" << std::hex << state.c_oflag << '\n';
	s << "  c_cflag=0x" << std::hex << state.c_cflag << '\n';
	s << "  c_lflag=0x" << std::hex << state.c_lflag << '\n';
	s << "  c_line=0x" << std::hex << static_cast<unsigned int>(state.c_line) << '\n';
	for (size_t i = 0; i < NCCS; ++i) {
		s << "  c_cc[" << std::dec << i << "]=0x" << std::hex << static_cast<unsigned int>(state.c_cc[i]) << '\n';
	}
	s << "  c_ispeed=0x" << std::hex << state.c_ispeed << '\n';
	s << "  c_ospeed=0x" << std::hex << state.c_ospeed;
	return s.str();
}

void check_tty_state_is_equal(const struct termios &a, const struct termios &b) {
	#define CHECK(field) \
		do { \
			if (a.field != b.field) { \
				std::ostringstream s; \
				s << "TTY state mismatch: " << #field << " 0x" << static_cast<unsigned int>(a.field) << " != " << static_cast<unsigned int>(b.field); \
				throw std::runtime_error(s.str()); \
			} \
		} while (0);

	CHECK(c_iflag);
	CHECK(c_oflag);
	CHECK(c_cflag);
	CHECK(c_lflag);
	CHECK(c_line);
	for (size_t i = 0; i < NCCS; ++i) {
		if (a.c_cc[i] != b.c_cc[i]) {
			std::ostringstream s;
			s << "TTY state mismatch: c_cc[" << std::dec << i << "] 0x" << static_cast<unsigned int>(a.c_cc[i]) << " != " << static_cast<unsigned int>(b.c_cc[i]);
			throw std::runtime_error(s.str());
		}
	}
	CHECK(c_ispeed);
	CHECK(c_ospeed);

	#undef CHECK
}

struct termios get_tty_attr(int fd, const std::string &description) {
	struct termios attr;
	if (tcgetattr(fd, &attr) < 0) {
		const int e = errno;
		throw std::system_error(e, std::system_category(), "tcgetattr() failed for " + description);
	}
	return attr;
}

void apply_tty_attr(int fd, const std::string &description, const struct termios &wanted) {
	if (tcsetattr(fd, TCSANOW, &wanted) < 0) {
		const int e = errno;
		throw std::system_error(e, std::system_category(), "tcsetattr() failed for " + description);
	}

	// tcsetattr() may only apply some settings, instead of all, so we have to re-check the resulting state.
	const struct termios actual = get_tty_attr(fd, description);
	try {
		check_tty_state_is_equal(wanted, actual);
	} catch (const std::exception &e) {
		throw std::runtime_error(
			"tcsetattr() failed to apply all the wanted settings for " + description + "\n" +
			e.what() + "\n" +
			"wanted: " + dump_tty_state(wanted) + "\n" +
			"actual: " + dump_tty_state(wanted)
		);
	}
}

class tty_state_accessor {
	int m_fd = -1;
	std::string m_description;
public:
	tty_state_accessor(int fd, const std::string &description)
		: m_fd(fd)
		, m_description(description)
	{
		if (!is_a_tty()) {
			throw std::runtime_error(m_description + " is not a tty. This test requires a TTY though, to test the FB runtime's TTY handling.");
		}
	}

	const std::string &get_description() const {
		return m_description;
	}

	bool is_a_tty() const {
		return isatty(m_fd);
	}

	struct termios get_live_state() const {
		return get_tty_attr(m_fd, m_description);
	}

	void apply_state(const struct termios &state) const {
		apply_tty_attr(m_fd, m_description, state);
	}

	bool is_echoing_enabled() const {
		const struct termios live = get_live_state();
		return ((live.c_lflag & ECHO) != 0);
	}

	void set_echoing(bool enable) const {
		struct termios state = get_live_state();
		if (enable) {
			state.c_lflag |= ECHO;
		} else {
			state.c_lflag &= ~ECHO;
		}
		apply_state(state);
	}
};

class tty_state_tracker {
	tty_state_accessor m_accessor;
	std::optional<struct termios> m_saved_state;

	void ensure_captured() const {
		if (!m_saved_state) {
			throw std::logic_error("restore() without capture()");
		}
	}

public:
	explicit tty_state_tracker(tty_state_accessor accessor)
		: m_accessor(accessor)
	{
	}

	void capture() {
		m_saved_state = m_accessor.get_live_state();
	}

	void restore() const {
		ensure_captured();
		m_accessor.apply_state(*m_saved_state);
	}

	struct unexpected_state_error : public std::runtime_error {
		using std::runtime_error::runtime_error;
	};

	void check_live_equals_captured() const {
		ensure_captured();
		const auto live = m_accessor.get_live_state();
		try {
			check_tty_state_is_equal(live, *m_saved_state);
		} catch (const std::exception &e) {
			throw unexpected_state_error("Unexpected TTY state for " + m_accessor.get_description() + ". " + e.what());
		}
	}

	void sanity_check() const {
		ensure_captured();

		const bool echoing = m_accessor.is_echoing_enabled();
		if (!echoing) {
			throw std::runtime_error("Echoing was initially disabled for " + m_accessor.get_description());
		}

		m_accessor.set_echoing(false);
		try {
			check_live_equals_captured();
			throw std::runtime_error("Sanity check failed: Did not detect disabled echoing");
		} catch (const unexpected_state_error &e) {
		}

		m_accessor.set_echoing(true);
		try {
			check_live_equals_captured();
		} catch (...) {
			throw std::runtime_error("Sanity check failed: Unexpectedly reported a state mismatch after re-enabling echoing");
		}
	}
};

class system_state_tracker {
	tty_state_tracker m_in{tty_state_accessor{STDIN_FILENO, "input tty"}};
	tty_state_tracker m_out{tty_state_accessor{STDOUT_FILENO, "output tty"}};
public:
	system_state_tracker() {
		capture();
	}

	void capture() {
		m_in.capture();
		m_out.capture();
	}

	void restore() const {
		m_in.restore();
		m_out.restore();
	}

	void check_live_equals_captured() const {
		m_in.check_live_equals_captured();
		m_out.check_live_equals_captured();
	}

	void sanity_check() const {
		m_in.sanity_check();
		m_out.sanity_check();
	}
};

void run_child_program(const std::string &path) {
	const pid_t childpid = fork();
	if (childpid < 0) {
		const int e = errno;
		throw std::system_error(e, std::system_category(), "fork() failed");
	}

	if (childpid == 0) {
		// In child
		const char *const argv[] = {
			path.c_str(),
			nullptr,
		};
		execv(path.c_str(), const_cast<char *const *>(argv));
		const int e = errno;
		throw std::system_error(e, std::system_category(), "Failed to execute program \"" + path + "\"");
	}

	// In parent
	int status = 0;
	if (waitpid(childpid, &status, 0) < 0) {
		const int e = errno;
		throw std::system_error(e, std::system_category(), "waitpid() failed");
	}
	if (WIFEXITED(status)) {
		const int exitcode = WEXITSTATUS(status);
		if (exitcode != 0) {
			throw std::runtime_error("Unexpected exit code " + std::to_string(exitcode) + " from child program " + path);
		}
	} else if (WIFSIGNALED(status)) {
		throw std::runtime_error("Unexpected exit due to signal " + std::to_string(WTERMSIG(status)) + " from child program " + path);
	} else {
		throw std::runtime_error("Unexpected exit from child program " + path);
	}
}

class test_context {
	system_state_tracker m_tracker;
	uint32_t m_oks = 0;
	uint32_t m_fails = 0;

	void test_child_process(const std::string &testee_name) {
		printf("test: %s... ", testee_name.c_str());
		fflush(stdout);
		run_child_program("./" + testee_name);
		try {
			m_tracker.check_live_equals_captured();
			m_oks++;
			printf("OK\n");
		} catch (const tty_state_tracker::unexpected_state_error &e) {
			m_fails++;
			m_tracker.restore();
			m_tracker.check_live_equals_captured();
			printf("FAIL: %s\n", e.what());
		}
	}

public:
	test_context() {
		m_tracker.sanity_check();
		printf("sanity check: OK\n");
	}

	void run() {
		test_child_process("testee-chain-examplebin");
		test_child_process("testee-chain-true");
		test_child_process("testee-do-nothing");
		test_child_process("testee-dylibload-dylibfree-examplelib");
		test_child_process("testee-dylibload-only-examplelib");
		test_child_process("testee-exec-examplebin");
		test_child_process("testee-exec-true");
		test_child_process("testee-open-pipe-examplebin");
		test_child_process("testee-open-pipe-true");
		test_child_process("testee-parallel-shell-sleep");
		test_child_process("testee-run-examplebin");
		test_child_process("testee-run-true");
		test_child_process("testee-shell-examplebin");
		test_child_process("testee-shell-true");

		printf("done: %" PRIu32 " OKs, %" PRIu32 " FAILs\n", m_oks, m_fails);
	}

	bool succeeded() const {
		return (m_fails == 0);
	}
};

} // namespace

int main() {
	try {
		test_context test;
		test.run();
		return test.succeeded() ? 0 : 1;
	} catch (const std::exception &e) {
		fprintf(stderr, "error: %s\n", e.what());
		return 1;
	}
}
