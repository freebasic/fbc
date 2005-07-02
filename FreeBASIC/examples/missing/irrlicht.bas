#include once <irrlicht-c.bi>

	dim as E_DRIVER_TYPE driverType = EDT_OPENGL

	dim as IrrlichtDevice ptr device = _
		createDevice( driverType, dimension2d_s32(640, 480) )

	if (device = 0) then
		end 1
	end if

	dim as IVideoDriver ptr driver = device->getVideoDriver( device )
	dim as ISceneManager ptr smgr = device->getSceneManager( device )

	device->getFileSystem( device )->addZipFileArchive( ???, "../../media/map-20kdm2.pk3" )

	dim as IAnimatedMesh ptr mesh = smgr->getMesh( smgr, "20kdm2.bsp" )
	dim as ISceneNode ptr node = 0
	
	if (mesh) then
		node = smgr->addOctTreeSceneNode( smgr, mesh->getMesh( mesh, 0 ) )
	end if

	if (node) then
		node->setPosition( node, vector3df(-1300,-144,-1249) )
	end if

	smgr->addCameraSceneNodeFPS( smgr )

	device->getCursorControl(device)->setVisible( ???, 0 )

	dim as integer lastFPS = -1

	do while( device->run( device ) )
		if (device->isWindowActive( device ) ) then
			driver->beginScene( driver, 1, 1, SColor(0,200,200,200) )
			smgr->drawAll( smgr )
			driver->endScene( driver )

			dim as integer fps = driver->getFPS( driver )

			if (lastFPS <> fps) then
				dim as wstring str = "Irrlicht Engine - Quake 3 Map example ["
				str += *driver->getName( driver )
				str += "] FPS:"
				str += str$( fps )

				device->setWindowCaption( device, str->c_str( str ) )
				lastFPS = fps
			end if
		end if
	loop

	device->drop( device )
	
	end 0

