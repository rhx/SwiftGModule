
extension gboolean {
    private init(_ b: Bool) { self = b ? gboolean(1) : gboolean(0) }
}

func asStringArray(_ param: UnsafePointer<UnsafePointer<CChar>?>) -> [String] {
    var ptr = param
    var rv = [String]()
    while ptr.pointee != nil {
        rv.append(String(cString: ptr.pointee!))
        ptr = ptr.successor()
    }
    return rv
}

func asStringArray<T>(_ param: UnsafePointer<UnsafePointer<CChar>?>, release: ((UnsafePointer<T>?) -> Void)) -> [String] {
    let rv = asStringArray(param)
    param.withMemoryRebound(to: T.self, capacity: rv.count) { release(UnsafePointer<T>($0)) }
    return rv
}
import CGLib
import GLib








/// Specifies the type of the module initialization function.
/// If a module contains a function named `g_module_check_init()` it is called
/// automatically when the module is loaded. It is passed the `GModule` structure
/// and should return `nil` on success or a string describing the initialization
/// error.
public typealias ModuleCheckInit = GModuleCheckInit

/// Specifies the type of the module function called when it is unloaded.
/// If a module contains a function named `g_module_unload()` it is called
/// automatically when the module is unloaded.
/// It is passed the `GModule` structure.
public typealias ModuleUnload = GModuleUnload
/// Flags passed to `g_module_open()`.
/// Note that these flags are not supported on all platforms.
public struct ModuleFlags: OptionSet {
    /// The corresponding value of the raw type
    public var rawValue: UInt32 = 0
    /// The equivalent raw Int value
    @inlinable public var intValue: Int { get { Int(rawValue) } set { rawValue = UInt32(newValue) } }
    /// The equivalent raw `gint` value
    @inlinable public var int: gint { get { gint(rawValue) } set { rawValue = UInt32(newValue) } }
    /// The equivalent underlying `GModuleFlags` enum value
    @inlinable public var value: GModuleFlags {
        get {
            func castToGModuleFlagsInt<I: BinaryInteger, J: BinaryInteger>(_ param: I) -> J { J(param) }
            return GModuleFlags(rawValue: castToGModuleFlagsInt(rawValue))
        }
        set { rawValue = UInt32(newValue.rawValue) }
    }

    /// Creates a new instance with the specified raw value
    @inlinable public init(rawValue: UInt32) { self.rawValue = rawValue }
    /// Creates a new instance with the specified `GModuleFlags` enum value
    @inlinable public init(_ enumValue: GModuleFlags) { self.rawValue = UInt32(enumValue.rawValue) }
    /// Creates a new instance with the specified Int value
    @inlinable public init<I: BinaryInteger>(_ intValue: I) { self.rawValue = UInt32(intValue)  }

    /// specifies that symbols are only resolved when
    ///     needed. The default action is to bind all symbols when the module
    ///     is loaded.
    public static let `lazy` = ModuleFlags(1) // G_MODULE_BIND_LAZY
    /// specifies that symbols in the module should
    ///     not be added to the global name space. The default action on most
    ///     platforms is to place symbols in the module in the global name space,
    ///     which may cause conflicts with existing symbols.
    public static let local = ModuleFlags(2) // G_MODULE_BIND_LOCAL
    /// mask for all flags.
    public static let mask = ModuleFlags(3) // G_MODULE_BIND_MASK
}


/// A portable way to build the filename of a module. The platform-specific
/// prefix and suffix are added to the filename, if needed, and the result
/// is added to the directory, using the correct separator character.
/// 
/// The directory should specify the directory where the module can be found.
/// It can be `nil` or an empty string to indicate that the module is in a
/// standard platform-specific directory, though this is not recommended
/// since the wrong module may be found.
/// 
/// For example, calling `g_module_build_path()` on a Linux system with a
/// `directory` of `/lib` and a `module_name` of "mylibrary" will return
/// `/lib/libmylibrary.so`. On a Windows system, using `\Windows` as the
/// directory it will return `\Windows\mylibrary.dll`.
@inlinable public func moduleBuildPath(directory: UnsafePointer<gchar>? = nil, moduleName: UnsafePointer<gchar>!) -> String! {
    guard let rv = g_module_build_path(directory, moduleName).map({ String(cString: $0) }) else { return nil }
    return rv
}




/// Gets a string describing the last module error.
@inlinable public func moduleError() -> String! {
    guard let rv = g_module_error().map({ String(cString: $0) }) else { return nil }
    return rv
}




/// Checks if modules are supported on the current platform.
@inlinable public func moduleSupported() -> Bool {
    let rv = ((g_module_supported()) != 0)
    return rv
}



// MARK: - Module Record

/// The `ModuleProtocol` protocol exposes the methods and properties of an underlying `GModule` instance.
/// The default implementation of these can be found in the protocol extension below.
/// For a concrete class that implements these methods and properties, see `Module`.
/// Alternatively, use `ModuleRef` as a lighweight, `unowned` reference if you already have an instance you just want to use.
///
/// The `GModule` struct is an opaque data structure to represent a
/// [dynamically-loaded module](#glib-Dynamic-Loading-of-Modules).
/// It should only be accessed via the following functions.
public protocol ModuleProtocol {
        /// Untyped pointer to the underlying `GModule` instance.
    var ptr: UnsafeMutableRawPointer! { get }

    /// Typed pointer to the underlying `GModule` instance.
    var _ptr: UnsafeMutablePointer<GModule>! { get }

    /// Required Initialiser for types conforming to `ModuleProtocol`
    init(raw: UnsafeMutableRawPointer)
}

/// The `ModuleRef` type acts as a lightweight Swift reference to an underlying `GModule` instance.
/// It exposes methods that can operate on this data type through `ModuleProtocol` conformance.
/// Use `ModuleRef` only as an `unowned` reference to an existing `GModule` instance.
///
/// The `GModule` struct is an opaque data structure to represent a
/// [dynamically-loaded module](#glib-Dynamic-Loading-of-Modules).
/// It should only be accessed via the following functions.
public struct ModuleRef: ModuleProtocol {
        /// Untyped pointer to the underlying `GModule` instance.
    /// For type-safe access, use the generated, typed pointer `_ptr` property instead.
    public let ptr: UnsafeMutableRawPointer!
}

public extension ModuleRef {
    /// Designated initialiser from the underlying `C` data type
    @inlinable init(_ p: UnsafeMutablePointer<GModule>) {
        ptr = UnsafeMutableRawPointer(p)
    }

    /// Designated initialiser from a constant pointer to the underlying `C` data type
    @inlinable init(_ p: UnsafePointer<GModule>) {
        ptr = UnsafeMutableRawPointer(UnsafeMutablePointer(mutating: p))
    }

    /// Conditional initialiser from an optional pointer to the underlying `C` data type
    @inlinable init!(_ maybePointer: UnsafeMutablePointer<GModule>?) {
        guard let p = maybePointer else { return nil }
        ptr = UnsafeMutableRawPointer(p)
    }

    /// Conditional initialiser from an optional, non-mutable pointer to the underlying `C` data type
    @inlinable init!(_ maybePointer: UnsafePointer<GModule>?) {
        guard let p = UnsafeMutablePointer(mutating: maybePointer) else { return nil }
        ptr = UnsafeMutableRawPointer(p)
    }

    /// Conditional initialiser from an optional `gpointer`
    @inlinable init!(gpointer g: gpointer?) {
        guard let p = g else { return nil }
        ptr = UnsafeMutableRawPointer(p)
    }

    /// Conditional initialiser from an optional, non-mutable `gconstpointer`
    @inlinable init!(gconstpointer g: gconstpointer?) {
        guard let p = UnsafeMutableRawPointer(mutating: g) else { return nil }
        ptr = p
    }

    /// Reference intialiser for a related type that implements `ModuleProtocol`
    @inlinable init<T: ModuleProtocol>(_ other: T) {
        ptr = other.ptr
    }

    /// Unsafe typed initialiser.
    /// **Do not use unless you know the underlying data type the pointer points to conforms to `ModuleProtocol`.**
    @inlinable init<T>(cPointer: UnsafeMutablePointer<T>) {
        ptr = UnsafeMutableRawPointer(cPointer)
    }

    /// Unsafe typed initialiser.
    /// **Do not use unless you know the underlying data type the pointer points to conforms to `ModuleProtocol`.**
    @inlinable init<T>(constPointer: UnsafePointer<T>) {
        ptr = UnsafeMutableRawPointer(mutating: UnsafeRawPointer(constPointer))
    }

    /// Unsafe untyped initialiser.
    /// **Do not use unless you know the underlying data type the pointer points to conforms to `ModuleProtocol`.**
    @inlinable init(mutating raw: UnsafeRawPointer) {
        ptr = UnsafeMutableRawPointer(mutating: raw)
    }

    /// Unsafe untyped initialiser.
    /// **Do not use unless you know the underlying data type the pointer points to conforms to `ModuleProtocol`.**
    @inlinable init(raw: UnsafeMutableRawPointer) {
        ptr = raw
    }

    /// Unsafe untyped initialiser.
    /// **Do not use unless you know the underlying data type the pointer points to conforms to `ModuleProtocol`.**
    @inlinable init(opaquePointer: OpaquePointer) {
        ptr = UnsafeMutableRawPointer(opaquePointer)
    }

        /// Opens a module. If the module has already been opened,
    /// its reference count is incremented.
    /// 
    /// First of all `g_module_open()` tries to open `file_name` as a module.
    /// If that fails and `file_name` has the ".la"-suffix (and is a libtool
    /// archive) it tries to open the corresponding module. If that fails
    /// and it doesn't have the proper module suffix for the platform
    /// (`G_MODULE_SUFFIX`), this suffix will be appended and the corresponding
    /// module will be opened. If that fails and `file_name` doesn't have the
    /// ".la"-suffix, this suffix is appended and `g_module_open()` tries to open
    /// the corresponding module. If eventually that fails as well, `nil` is
    /// returned.
    @inlinable static func open(fileName: UnsafePointer<gchar>? = nil, flags: ModuleFlags) -> ModuleRef! {
        guard let rv = ModuleRef(gconstpointer: gconstpointer(g_module_open(fileName, flags.value))) else { return nil }
        return rv
    }
}

/// The `Module` type acts as an owner of an underlying `GModule` instance.
/// It provides the methods that can operate on this data type through `ModuleProtocol` conformance.
/// Use `Module` as a strong reference or owner of a `GModule` instance.
///
/// The `GModule` struct is an opaque data structure to represent a
/// [dynamically-loaded module](#glib-Dynamic-Loading-of-Modules).
/// It should only be accessed via the following functions.
open class Module: ModuleProtocol {
        /// Untyped pointer to the underlying `GModule` instance.
    /// For type-safe access, use the generated, typed pointer `_ptr` property instead.
    public let ptr: UnsafeMutableRawPointer!

    /// Designated initialiser from the underlying `C` data type.
    /// This creates an instance without performing an unbalanced retain
    /// i.e., ownership is transferred to the `Module` instance.
    /// - Parameter op: pointer to the underlying object
    @inlinable public init(_ op: UnsafeMutablePointer<GModule>) {
        ptr = UnsafeMutableRawPointer(op)
    }

    /// Designated initialiser from a constant pointer to the underlying `C` data type.
    /// This creates an instance without performing an unbalanced retain
    /// i.e., ownership is transferred to the `Module` instance.
    /// - Parameter op: pointer to the underlying object
    @inlinable public init(_ op: UnsafePointer<GModule>) {
        ptr = UnsafeMutableRawPointer(UnsafeMutablePointer(mutating: op))
    }

    /// Optional initialiser from a non-mutating `gpointer` to
    /// the underlying `C` data type.
    /// This creates an instance without performing an unbalanced retain
    /// i.e., ownership is transferred to the `Module` instance.
    /// - Parameter op: gpointer to the underlying object
    @inlinable public init!(gpointer op: gpointer?) {
        guard let p = UnsafeMutableRawPointer(op) else { return nil }
        ptr = p
    }

    /// Optional initialiser from a non-mutating `gconstpointer` to
    /// the underlying `C` data type.
    /// This creates an instance without performing an unbalanced retain
    /// i.e., ownership is transferred to the `Module` instance.
    /// - Parameter op: pointer to the underlying object
    @inlinable public init!(gconstpointer op: gconstpointer?) {
        guard let p = op else { return nil }
        ptr = UnsafeMutableRawPointer(mutating: p)
    }

    /// Optional initialiser from a constant pointer to the underlying `C` data type.
    /// This creates an instance without performing an unbalanced retain
    /// i.e., ownership is transferred to the `Module` instance.
    /// - Parameter op: pointer to the underlying object
    @inlinable public init!(_ op: UnsafePointer<GModule>?) {
        guard let p = UnsafeMutablePointer(mutating: op) else { return nil }
        ptr = UnsafeMutableRawPointer(p)
    }

    /// Optional initialiser from the underlying `C` data type.
    /// This creates an instance without performing an unbalanced retain
    /// i.e., ownership is transferred to the `Module` instance.
    /// - Parameter op: pointer to the underlying object
    @inlinable public init!(_ op: UnsafeMutablePointer<GModule>?) {
        guard let p = op else { return nil }
        ptr = UnsafeMutableRawPointer(p)
    }

    /// Designated initialiser from the underlying `C` data type.
    /// `GModule` does not allow reference counting, so despite the name no actual retaining will occur.
    /// i.e., ownership is transferred to the `Module` instance.
    /// - Parameter op: pointer to the underlying object
    @inlinable public init(retaining op: UnsafeMutablePointer<GModule>) {
        ptr = UnsafeMutableRawPointer(op)
        // no reference counting for GModule, cannot ref(_ptr)
    }

    /// Reference intialiser for a related type that implements `ModuleProtocol`
    /// `GModule` does not allow reference counting.
    /// - Parameter other: an instance of a related type that implements `ModuleProtocol`
    @inlinable public init<T: ModuleProtocol>(_ other: T) {
        ptr = other.ptr
        // no reference counting for GModule, cannot ref(_ptr)
    }

    /// Do-nothing destructor for `GModule`.
    deinit {
        // no reference counting for GModule, cannot unref(_ptr)
    }

    /// Unsafe typed initialiser.
    /// **Do not use unless you know the underlying data type the pointer points to conforms to `ModuleProtocol`.**
    /// - Parameter cPointer: pointer to the underlying object
    @inlinable public init<T>(cPointer p: UnsafeMutablePointer<T>) {
        ptr = UnsafeMutableRawPointer(p)
    }

    /// Unsafe typed, retaining initialiser.
    /// **Do not use unless you know the underlying data type the pointer points to conforms to `ModuleProtocol`.**
    /// - Parameter cPointer: pointer to the underlying object
    @inlinable public init<T>(retainingCPointer cPointer: UnsafeMutablePointer<T>) {
        ptr = UnsafeMutableRawPointer(cPointer)
        // no reference counting for GModule, cannot ref(_ptr)
    }

    /// Unsafe untyped initialiser.
    /// **Do not use unless you know the underlying data type the pointer points to conforms to `ModuleProtocol`.**
    /// - Parameter p: raw pointer to the underlying object
    @inlinable public init(raw p: UnsafeRawPointer) {
        ptr = UnsafeMutableRawPointer(mutating: p)
    }

    /// Unsafe untyped, retaining initialiser.
    /// **Do not use unless you know the underlying data type the pointer points to conforms to `ModuleProtocol`.**
    @inlinable public init(retainingRaw raw: UnsafeRawPointer) {
        ptr = UnsafeMutableRawPointer(mutating: raw)
        // no reference counting for GModule, cannot ref(_ptr)
    }

    /// Unsafe untyped initialiser.
    /// **Do not use unless you know the underlying data type the pointer points to conforms to `ModuleProtocol`.**
    /// - Parameter p: mutable raw pointer to the underlying object
    @inlinable public required init(raw p: UnsafeMutableRawPointer) {
        ptr = p
    }

    /// Unsafe untyped, retaining initialiser.
    /// **Do not use unless you know the underlying data type the pointer points to conforms to `ModuleProtocol`.**
    /// - Parameter raw: mutable raw pointer to the underlying object
    @inlinable public init(retainingRaw raw: UnsafeMutableRawPointer) {
        ptr = raw
        // no reference counting for GModule, cannot ref(_ptr)
    }

    /// Unsafe untyped initialiser.
    /// **Do not use unless you know the underlying data type the pointer points to conforms to `ModuleProtocol`.**
    /// - Parameter p: opaque pointer to the underlying object
    @inlinable public init(opaquePointer p: OpaquePointer) {
        ptr = UnsafeMutableRawPointer(p)
    }

    /// Unsafe untyped, retaining initialiser.
    /// **Do not use unless you know the underlying data type the pointer points to conforms to `ModuleProtocol`.**
    /// - Parameter p: opaque pointer to the underlying object
    @inlinable public init(retainingOpaquePointer p: OpaquePointer) {
        ptr = UnsafeMutableRawPointer(p)
        // no reference counting for GModule, cannot ref(_ptr)
    }


    /// Opens a module. If the module has already been opened,
    /// its reference count is incremented.
    /// 
    /// First of all `g_module_open()` tries to open `file_name` as a module.
    /// If that fails and `file_name` has the ".la"-suffix (and is a libtool
    /// archive) it tries to open the corresponding module. If that fails
    /// and it doesn't have the proper module suffix for the platform
    /// (`G_MODULE_SUFFIX`), this suffix will be appended and the corresponding
    /// module will be opened. If that fails and `file_name` doesn't have the
    /// ".la"-suffix, this suffix is appended and `g_module_open()` tries to open
    /// the corresponding module. If eventually that fails as well, `nil` is
    /// returned.
    @inlinable public static func open(fileName: UnsafePointer<gchar>? = nil, flags: ModuleFlags) -> Module! {
        guard let rv = Module(gconstpointer: gconstpointer(g_module_open(fileName, flags.value))) else { return nil }
        return rv
    }

}

// MARK: no Module properties

// MARK: no Module signals

// MARK: Module has no signals
// MARK: Module Record: ModuleProtocol extension (methods and fields)
public extension ModuleProtocol {
    /// Return the stored, untyped pointer as a typed pointer to the `GModule` instance.
    @inlinable var _ptr: UnsafeMutablePointer<GModule>! { return ptr?.assumingMemoryBound(to: GModule.self) }

    /// Closes a module.
    @inlinable func close() -> Bool {
        let rv = ((g_module_close(_ptr)) != 0)
        return rv
    }

    /// Ensures that a module will never be unloaded.
    /// Any future `g_module_close()` calls on the module will be ignored.
    @inlinable func makeResident() {
        g_module_make_resident(_ptr)
    
    }

    /// Returns the filename that the module was opened with.
    /// 
    /// If `module` refers to the application itself, "main" is returned.
    @inlinable func name() -> String! {
        let rv = g_module_name(_ptr).map({ String(cString: $0) })
        return rv
    }

    /// Gets a symbol pointer from a module, such as one exported
    /// by `G_MODULE_EXPORT`. Note that a valid symbol can be `nil`.
    @inlinable func symbol(symbolName: UnsafePointer<gchar>!, symbol: UnsafeMutablePointer<gpointer?>?) -> Bool {
        let rv = ((g_module_symbol(_ptr, symbolName, symbol)) != 0)
        return rv
    }


}


