import CGLib
import GLib

public typealias _GModule_ModuleProtocol = ModuleProtocol


public typealias _GModule_Module = Module

public extension GModule {
    typealias ModuleProtocol = _GModule_ModuleProtocol

    typealias Module = _GModule_Module
    typealias ModuleCheckInit = GModuleCheckInit
    typealias ModuleUnload = GModuleUnload
    typealias ModuleFlags = GModuleFlags
}
