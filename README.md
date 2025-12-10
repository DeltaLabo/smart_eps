# Smart EPS

## Goal

Developing of a Electrical Power System for CubeSats that enables mission automation by providing advanced functionality and telemetry

## sysON Server

[Link to server](http://localhost:8080)

## Initial folder structure
```text
smartEPS/
├─ docs/                     # high-level docs, reviews, meeting notes
│  ├─ icd/                   # Interface Control Documents
│  └─ adr/                   # Architecture Decision Records
├─ model/                    # SysML v2 + scripts
│   ├─ context/
│   ├─ needs/
│   ├─ requirements/
│   │   ├─ system/
│   │   └─ eps/
│   ├─ logical/
│   ├─ physical/
│   ├─ behavior/
│   └─ verification/
├─ electronics/              # EE CAD and fabrication artifacts
│  ├─ pcb/                   # CAD projects per board
│  ├─ outputs/               # Gerbers, IPC-2581, ODB++, pick&place
│  └─ sim/                   # SPICE, PSIM, LTspice, etc.
├─ mechanical/               # enclosures, STEP, drawings
├─ software/                 # firmware/tools that interact with EPS
├─ bom/                      # CSV/TSV BOMs, AVL, costing
├─ verification/             # test procedures, results, logs
├─ scripts/                  # glue: build, export, report generation
├─ .gitattributes            # Git LFS patterns (see below)
├─ .gitignore
├─ requirements.txt          # Python deps (e.g., sysml2py, pandas)
└─ README.md
