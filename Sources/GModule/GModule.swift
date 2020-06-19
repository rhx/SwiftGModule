public extension ModuleFlags {
    /// specifies that symbols are only resolved when
    ///     needed. The default action is to bind all symbols when the module
    ///     is loaded.
    static let `lazy`: ModuleFlags = .lazy_
}
