
func cast(_ param: UInt)   -> Int    {    Int(bitPattern: param) }
func cast(_ param: Int)    -> UInt   {   UInt(bitPattern: param) }
func cast(_ param: UInt16) -> Int16  {  Int16(bitPattern: param) }
func cast(_ param: Int16)  -> UInt16 { UInt16(bitPattern: param) }
func cast(_ param: UInt32) -> Int32  {  Int32(bitPattern: param) }
func cast(_ param: Int32)  -> UInt32 { UInt32(bitPattern: param) }
func cast(_ param: UInt64) -> Int64  {  Int64(bitPattern: param) }
func cast(_ param: Int64)  -> UInt64 { UInt64(bitPattern: param) }
func cast(_ param: Float)  -> Double { Double(param) }
func cast(_ param: Float80) -> Double { Double(param) }
func cast(_ param: Double) -> Float { Float(param) }
func cast(_ param: Double) -> Float80 { Float80(param) }
func cast<U: UnsignedInteger>(_ param: U) -> Int { Int(param) }
func cast<S: SignedInteger>(_ param: S) -> Int { Int(param) }
func cast<U: UnsignedInteger>(_ param: Int) -> U { U(param) }
func cast<S: SignedInteger>(_ param: Int) -> S  { S(param) }
func cast<I: BinaryInteger>(_ param: I) -> Int32 { Int32(param) }
func cast<I: BinaryInteger>(_ param: I) -> UInt32 { UInt32(param) }
func cast<I: BinaryInteger>(_ param: I) -> Bool { param != 0 }
func cast<I: BinaryInteger>(_ param: Bool) -> I { param ? 1 : 0 }

func cast(_ param: UnsafeRawPointer?) -> String! {
    return param.map { String(cString: $0.assumingMemoryBound(to: CChar.self)) }
}

func cast(_ param: OpaquePointer?) -> String! {
    return param.map { String(cString: UnsafePointer<CChar>($0)) }
}

func cast(_ param: UnsafeRawPointer) -> OpaquePointer! {
    return OpaquePointer(param)
}

func cast<S, T>(_ param: UnsafeMutablePointer<S>?) -> UnsafeMutablePointer<T>! {
    return param?.withMemoryRebound(to: T.self, capacity: 1) { $0 }
}

func cast<S, T>(_ param: UnsafeMutablePointer<S>?) -> UnsafePointer<T>! {
    return param?.withMemoryRebound(to: T.self, capacity: 1) { UnsafePointer<T>($0) }
}

func cast<S, T>(_ param: UnsafePointer<S>?) -> UnsafePointer<T>! {
    return param?.withMemoryRebound(to: T.self, capacity: 1) { UnsafePointer<T>($0) }
}

func cast<T>(_ param: OpaquePointer?) -> UnsafeMutablePointer<T>! {
    return UnsafeMutablePointer<T>(param)
}

func cast<T>(_ param: OpaquePointer?) -> UnsafePointer<T>! {
    return UnsafePointer<T>(param)
}

func cast(_ param: OpaquePointer?) -> UnsafeMutableRawPointer! {
    return UnsafeMutableRawPointer(param)
}

func cast(_ param: UnsafeRawPointer?) -> UnsafeMutableRawPointer! {
    return UnsafeMutableRawPointer(mutating: param)
}

func cast<T>(_ param: UnsafePointer<T>?) -> OpaquePointer! {
    return OpaquePointer(param)
}

func cast<T>(_ param: UnsafeMutablePointer<T>?) -> OpaquePointer! {
    return OpaquePointer(param)
}

func cast<T>(_ param: UnsafeRawPointer?) -> UnsafeMutablePointer<T>! {
    return UnsafeMutableRawPointer(mutating: param)?.assumingMemoryBound(to: T.self)
}

func cast<T>(_ param: UnsafeMutableRawPointer?) -> UnsafeMutablePointer<T>! {
    return param?.assumingMemoryBound(to: T.self)
}

func cast<T>(_ param: T) -> T { return param }

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

public struct GModule {}







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
    public var intValue: Int { get { Int(rawValue) } set { rawValue = UInt32(newValue) } }
    /// The equivalent raw `gint` value
    public var int: gint { get { gint(rawValue) } set { rawValue = UInt32(newValue) } }
    /// The equivalent underlying `GModuleFlags` enum value
    public var value: GModuleFlags { get { GModuleFlags(rawValue: cast(rawValue)) } set { rawValue = UInt32(newValue.rawValue) } }

    /// Creates a new instance with the specified raw value
    public init(rawValue: UInt32) { self.rawValue = rawValue }
    /// Creates a new instance with the specified `GModuleFlags` enum value
    public init(_ enumValue: GModuleFlags) { self.rawValue = UInt32(enumValue.rawValue) }
    /// Creates a new instance with the specified Int value
    public init(_ intValue: Int)   { self.rawValue = UInt32(intValue)  }
    /// Creates a new instance with the specified `gint` value
    public init(_ gintValue: gint) { self.rawValue = UInt32(gintValue) }

    /// specifies that symbols are only resolved when
    ///     needed. The default action is to bind all symbols when the module
    ///     is loaded.
    public static let `lazy` = ModuleFlags(1) /* G_MODULE_BIND_LAZY */
    /// specifies that symbols in the module should
    ///     not be added to the global name space. The default action on most
    ///     platforms is to place symbols in the module in the global name space,
    ///     which may cause conflicts with existing symbols.
    public static let local = ModuleFlags(2) /* G_MODULE_BIND_LOCAL */
    /// mask for all flags.
    public static let mask = ModuleFlags(3) /* G_MODULE_BIND_MASK */

    /// specifies that symbols are only resolved when
    ///     needed. The default action is to bind all symbols when the module
    ///     is loaded.
    @available(*, deprecated) public static let lazy_ = ModuleFlags(1) /* G_MODULE_BIND_LAZY */
}
func cast<I: BinaryInteger>(_ param: I) -> ModuleFlags { ModuleFlags(rawValue: cast(param)) }
func cast(_ param: ModuleFlags) -> UInt32 { cast(param.rawValue) }

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
public func moduleBuildPath(directory: UnsafePointer<gchar>, moduleName module_name: UnsafePointer<gchar>) -> String! {
    let rv: String! = cast(g_module_build_path(directory, module_name))
    return cast(rv)
}




/// Gets a string describing the last module error.
public func moduleError() -> String! {
    let rv: String! = cast(g_module_error())
    return cast(rv)
}




/// Checks if modules are supported on the current platform.
public func moduleSupported() -> Bool {
    let rv = g_module_supported()
    return Bool(rv != 0)
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
    var ptr: UnsafeMutableRawPointer { get }

    /// Typed pointer to the underlying `GModule` instance.
    var _ptr: UnsafeMutablePointer<GModule> { get }
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
    public let ptr: UnsafeMutableRawPointer
}

public extension ModuleRef {
    /// Designated initialiser from the underlying `C` data type
    init(_ p: UnsafeMutablePointer<GModule>) {
        ptr = UnsafeMutableRawPointer(p)    }

    /// Reference intialiser for a related type that implements `ModuleProtocol`
    init<T: ModuleProtocol>(_ other: T) {
        ptr = other.ptr
    }

    /// Unsafe typed initialiser.
    /// **Do not use unless you know the underlying data type the pointer points to conforms to `ModuleProtocol`.**
    init<T>(cPointer: UnsafeMutablePointer<T>) {
        ptr = UnsafeMutableRawPointer(cPointer)
    }

    /// Unsafe typed initialiser.
    /// **Do not use unless you know the underlying data type the pointer points to conforms to `ModuleProtocol`.**
    init<T>(constPointer: UnsafePointer<T>) {
        ptr = UnsafeMutableRawPointer(mutating: UnsafeRawPointer(constPointer))
    }

    /// Unsafe untyped initialiser.
    /// **Do not use unless you know the underlying data type the pointer points to conforms to `ModuleProtocol`.**
    init(raw: UnsafeRawPointer) {
        ptr = UnsafeMutableRawPointer(mutating: raw)
    }

    /// Unsafe untyped initialiser.
    /// **Do not use unless you know the underlying data type the pointer points to conforms to `ModuleProtocol`.**
    init(raw: UnsafeMutableRawPointer) {
        ptr = raw
    }

    /// Unsafe untyped initialiser.
    /// **Do not use unless you know the underlying data type the pointer points to conforms to `ModuleProtocol`.**
    init(opaquePointer: OpaquePointer) {
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
    static func open(fileName file_name: UnsafePointer<gchar>, flags: ModuleFlags) -> ModuleRef! {
        let rv: UnsafeMutablePointer<GModule>! = cast(g_module_open(file_name, flags.value))
        return rv.map { ModuleRef(cast($0)) }
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
    public let ptr: UnsafeMutableRawPointer

    /// Designated initialiser from the underlying `C` data type.
    /// This creates an instance without performing an unbalanced retain
    /// i.e., ownership is transferred to the `Module` instance.
    /// - Parameter op: pointer to the underlying object
    public init(_ op: UnsafeMutablePointer<GModule>) {
        ptr = UnsafeMutableRawPointer(op)
    }

    /// Designated initialiser from the underlying `C` data type.
    /// `GModule` does not allow reference counting, so despite the name no actual retaining will occur.
    /// i.e., ownership is transferred to the `Module` instance.
    /// - Parameter op: pointer to the underlying object
    public init(retaining op: UnsafeMutablePointer<GModule>) {
        ptr = UnsafeMutableRawPointer(op)
        // no reference counting for GModule, cannot ref(cast(_ptr))
    }

    /// Reference intialiser for a related type that implements `ModuleProtocol`
    /// `GModule` does not allow reference counting.
    /// - Parameter other: an instance of a related type that implements `ModuleProtocol`
    public init<T: ModuleProtocol>(_ other: T) {
        ptr = UnsafeMutableRawPointer(other._ptr)
        // no reference counting for GModule, cannot ref(cast(_ptr))
    }

    /// Do-nothing destructor for `GModule`.
    deinit {
        // no reference counting for GModule, cannot unref(cast(_ptr))
    }

    /// Unsafe typed initialiser.
    /// **Do not use unless you know the underlying data type the pointer points to conforms to `ModuleProtocol`.**
    /// - Parameter cPointer: pointer to the underlying object
    public init<T>(cPointer p: UnsafeMutablePointer<T>) {
        ptr = UnsafeMutableRawPointer(p)
    }

    /// Unsafe typed, retaining initialiser.
    /// **Do not use unless you know the underlying data type the pointer points to conforms to `ModuleProtocol`.**
    /// - Parameter cPointer: pointer to the underlying object
    public init<T>(retainingCPointer cPointer: UnsafeMutablePointer<T>) {
        ptr = UnsafeMutableRawPointer(cPointer)
        // no reference counting for GModule, cannot ref(cast(_ptr))
    }

    /// Unsafe untyped initialiser.
    /// **Do not use unless you know the underlying data type the pointer points to conforms to `ModuleProtocol`.**
    /// - Parameter p: raw pointer to the underlying object
    public init(raw p: UnsafeRawPointer) {
        ptr = UnsafeMutableRawPointer(mutating: p)
    }

    /// Unsafe untyped, retaining initialiser.
    /// **Do not use unless you know the underlying data type the pointer points to conforms to `ModuleProtocol`.**
    public init(retainingRaw raw: UnsafeRawPointer) {
        ptr = UnsafeMutableRawPointer(mutating: raw)
        // no reference counting for GModule, cannot ref(cast(_ptr))
    }

    /// Unsafe untyped initialiser.
    /// **Do not use unless you know the underlying data type the pointer points to conforms to `ModuleProtocol`.**
    /// - Parameter p: mutable raw pointer to the underlying object
    public init(raw p: UnsafeMutableRawPointer) {
        ptr = p
    }

    /// Unsafe untyped, retaining initialiser.
    /// **Do not use unless you know the underlying data type the pointer points to conforms to `ModuleProtocol`.**
    /// - Parameter raw: mutable raw pointer to the underlying object
    public init(retainingRaw raw: UnsafeMutableRawPointer) {
        ptr = raw
        // no reference counting for GModule, cannot ref(cast(_ptr))
    }

    /// Unsafe untyped initialiser.
    /// **Do not use unless you know the underlying data type the pointer points to conforms to `ModuleProtocol`.**
    /// - Parameter p: opaque pointer to the underlying object
    public init(opaquePointer p: OpaquePointer) {
        ptr = UnsafeMutableRawPointer(p)
    }

    /// Unsafe untyped, retaining initialiser.
    /// **Do not use unless you know the underlying data type the pointer points to conforms to `ModuleProtocol`.**
    /// - Parameter p: opaque pointer to the underlying object
    public init(retainingOpaquePointer p: OpaquePointer) {
        ptr = UnsafeMutableRawPointer(p)
        // no reference counting for GModule, cannot ref(cast(_ptr))
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
    public static func open(fileName file_name: UnsafePointer<gchar>, flags: ModuleFlags) -> Module! {
        let rv: UnsafeMutablePointer<GModule>! = cast(g_module_open(file_name, flags.value))
        return rv.map { Module(cast($0)) }
    }

}

// MARK: no Module properties

// MARK: no Module signals


// MARK: Module Record: ModuleProtocol extension (methods and fields)
public extension ModuleProtocol {
    /// Return the stored, untyped pointer as a typed pointer to the `GModule` instance.
    var _ptr: UnsafeMutablePointer<GModule> { return ptr.assumingMemoryBound(to: GModule.self) }

    /// Closes a module.
    func close() -> Bool {
        let rv = g_module_close(cast(_ptr))
        return Bool(rv != 0)
    }

    /// Ensures that a module will never be unloaded.
    /// Any future `g_module_close()` calls on the module will be ignored.
    func makeResident() {
        g_module_make_resident(cast(_ptr))
    
    }

    /// Returns the filename that the module was opened with.
    /// 
    /// If `module` refers to the application itself, "main" is returned.
    func name() -> String! {
        let rv: String! = cast(g_module_name(cast(_ptr)))
        return cast(rv)
    }

    /// Gets a symbol pointer from a module, such as one exported
    /// by `G_MODULE_EXPORT`. Note that a valid symbol can be `nil`.
    func symbol(symbolName symbol_name: UnsafePointer<gchar>, symbol: UnsafeMutablePointer<UnsafeMutableRawPointer>) -> Bool {
        let rv = g_module_symbol(cast(_ptr), symbol_name, cast(symbol))
        return Bool(rv != 0)
    }


}


