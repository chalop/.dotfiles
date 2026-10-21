# brew

Package lists, one per group. `bootstrap.sh` installs the ones you pick, or by hand:

```bash
brew bundle --file brew/Brewfile.core
```

| Group | What for |
|-------|----------|
| `core` | shell, editor, multiplexer, everyday CLI tooling |
| `desktop` | tiling window manager and window borders |
| `apps` | terminal emulators, GUI apps and their build dependencies |

Which config folders each group links is defined in `bootstrap.sh`.
