import CGLib
import GLib

/// The `GModule` struct is an opaque data structure to represent a
/// [dynamically-loaded module](#glib-Dynamic-Loading-of-Modules).
/// It should only be accessed via the following functions.
public typealias _GModule_Module = GModule // 




/// Errors returned by `g_module_open_full()`.
public typealias _GModule_ModuleError = GModuleError


/// Flags passed to `g_module_open()`.
/// Note that these flags are not supported on all platforms.
public typealias _GModule_ModuleFlags = GModuleFlags



extension GModule {


    /// The `GModule` struct is an opaque data structure to represent a
    /// [dynamically-loaded module](#glib-Dynamic-Loading-of-Modules).
    /// It should only be accessed via the following functions.
    public typealias Module = _GModule_Module




    /// Errors returned by `g_module_open_full()`.
    public typealias ModuleError = _GModule_ModuleError


    /// Flags passed to `g_module_open()`.
    /// Note that these flags are not supported on all platforms.
    public typealias ModuleFlags = _GModule_ModuleFlags



}

