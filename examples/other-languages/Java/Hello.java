// Compile with: javac Hello.java
class Hello {
    public static void hello(int i) throws Exception {
        System.out.println("Hello, you passed '" + Integer.toString(i) + "'..."); 
        System.out.println("I'm now going to sleep a second, and then throw an exception for testing purposes..."); 
        Thread.currentThread().sleep(1000);
        throw new Exception("Oh, this is an exception");
    }
}
