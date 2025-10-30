

## Initial folder structure
satellite-eps/
├─ docs/                     # high-level docs, reviews, meeting notes
│  ├─ icd/                   # Interface Control Documents
│  └─ adr/                   # Architecture Decision Records
├─ model/                    # SysML v2 + scripts
│  ├─ src/                   # *.sysml textual sources (KerML/SysMLv2)
│  ├─ views/                 # view definitions, diagrams, queries
│  ├─ exports/               # auto-generated: JSON/XMI/HTML reports
│  ├─ test/                  # model validation checks
│  └─ tools/                 # Python: parsing, CI checks, codegen
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
