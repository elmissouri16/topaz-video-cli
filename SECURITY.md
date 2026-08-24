# Security

Do not commit or share Topaz authentication files, model packages, cache directories, diagnostic logs, or terminal output containing authentication diagnostics.

The wrapper reads the existing activation file from the installed Topaz Video application and suppresses Topaz's verbose authentication-detail line. It does not copy credentials into this repository or its output files.

If credentials are accidentally committed, revoke or rotate them immediately and remove them from the complete Git history before pushing again.
