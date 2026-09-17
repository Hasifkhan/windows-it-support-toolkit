Ultimate IT Support Toolkit

**Professional Windows IT Support Toolkit | v3.1.1**

A menu-driven Windows command-line toolkit designed for practical IT support, diagnostics, troubleshooting, repair, reporting, and routine system administration.

> **Author:** Hasif Khan  
> **Project ID:** HK-ITST-2026-001  
> **Version:** 3.1.1 Professional Edition  
> **Platform:** Microsoft Windows

## Overview

The **Ultimate IT Support Toolkit** brings common Windows support tasks into a single structured console interface.

It is designed for IT support technicians, system administrators, helpdesk teams, and technical professionals who want a repeatable workflow instead of running individual commands manually.

## Modules

The toolkit currently includes 18 main modules:

1. PC Information
2. Hardware Diagnostics
3. Network Diagnostics
4. Internet Troubleshooting
5. Windows Repair
6. Disk & Storage
7. Performance
8. Services
9. User & Account Tools
10. Driver & Device Tools
11. Windows Update
12. Security & Firewall
13. Wi-Fi Tools
14. Report Generator
15. System Tools
16. Power & Shutdown
17. Quick IT Health Check
18. Exit

## Key Features

- Professional menu-driven console interface
- Administrator-status detection
- PC and Windows information
- CPU, RAM, BIOS and hardware diagnostics
- Network configuration and connectivity diagnostics
- DNS, ARP, routing and active connection tools
- Windows repair utilities
- Disk and storage diagnostics
- Performance and process inspection
- Windows service management
- User and local administrator tools
- Driver/device utilities
- Windows Update tools
- Firewall and security tools
- Wi-Fi diagnostics
- Automated support reports
- Activity logging
- Quick IT health check
- Safe confirmation before restart/shutdown operations
- Extended console scrollback for large command output
- Paging for long diagnostic results

## Console Output

Large diagnostic commands are paged where appropriate and the console has an extended scrollback buffer, making long outputs easier to review.

## Requirements

- Windows 10 or Windows 11
- Command Prompt
- PowerShell
- Some diagnostic/repair functions require **Administrator privileges**
- Certain Windows tools may not be available on every Windows edition

## How to Run

1. Download the `.bat` file.
2. Right-click it.
3. Select **Run as administrator** for full functionality.
4. Select a module from the main menu.
5. Follow the module prompts.

You can also launch it from an elevated Command Prompt.

## Safety Notes

This toolkit contains system administration and troubleshooting operations. Some functions can modify Windows configuration or perform actions such as restarting/shutting down the computer.

**Review the selected operation before executing it, especially on production systems.**

Do not run unknown or modified copies of the toolkit on systems where integrity matters.

## Project Structure

```text
.
├── HASIF-KHAN-ULTIMATE-IT-SUPPORT-TOOLKIT-v3.1.1.bat
├── README.md
├── LICENSE
├── SECURITY.md
├── CHANGELOG.md
└── .gitignore
```

## Release Integrity

**SHA-256**

```text
3d5e2032810ff0cb3a6d16be62a8d15815a455335c19b0e6a9cdcb3f2c492d2c
```

The hash can be independently verified with:

```bat
certutil -hashfile "HASIF-KHAN-ULTIMATE-IT-SUPPORT-TOOLKIT-v3.1.1.bat" SHA256
```

## Author

**Hasif Khan**

IT Support | System Administration | Windows | Network & Infrastructure | IT Operations

## Project ID

`HK-ITST-2026-001`

## License

This project is published publicly for demonstration, reference, and professional portfolio purposes.

The source remains **proprietary and all rights reserved** unless a separate written license is provided. See [`LICENSE`](LICENSE).

## Disclaimer

This project is provided as-is for IT support and educational/professional use. The author is not responsible for data loss, system changes, downtime, or other consequences resulting from use of the toolkit.

---
© 2026 Hasif Khan. All Rights Reserved.
