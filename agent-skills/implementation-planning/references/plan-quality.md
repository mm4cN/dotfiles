# Plan Quality Reference

A useful implementation plan is executable by another engineer without rediscovering the entire codebase.

Prefer:

- `lua/foo/init.lua: setup()` — add registration for the new backend after existing backend validation.
- Extend `tests/foo_spec.lua` with a regression case for an unknown backend.
- Run the focused test file, then the plugin test suite.

Avoid:

- Update implementation.
- Add tests.
- Make sure everything works.

A plan should expose uncertainty early. If behavior depends on an undocumented API, version-specific feature, generated file, or external service, state that explicitly.
