#!/usr/bin/env python3

from __future__ import annotations

import subprocess
from pathlib import Path


ROOT = Path(__file__).resolve().parent


COMMON = r'''
digraph G {
  graph [
    pad="0.3",
    nodesep="0.35",
    ranksep="0.5",
    splines=true,
    bgcolor="white"
  ];
  node [
    shape=box,
    style="rounded,filled",
    color="#263238",
    fillcolor="#F7F3E8",
    fontname="Helvetica",
    fontsize=11,
    margin="0.12,0.08"
  ];
  edge [
    color="#455A64",
    fontname="Helvetica",
    fontsize=10,
    arrowsize=0.7
  ];
'''


DIAGRAMS = {
    "RodneyWirewrapStack": COMMON + r'''
  rankdir=LR;

  CPU [label="Board A\nCPU / Bus", fillcolor="#E8F1E7"];
  MEM [label="Board B\nMemory / Decode", fillcolor="#FBE9D0"];
  IO [label="Board C\nBench I/O", fillcolor="#E7EEF7"];

  CPU -> MEM [label="A0-A15\nD0-D7\nRD WR IO/M"];
  CPU -> IO [label="A0-A15\nD0-D7\nRD WR IO/M"];
}
''',
    "RodneyBoardA": COMMON + r'''
  rankdir=TB;

  node [shape=record];

  Top [label="Top Edge\nTest Points / Reset", fillcolor="#E7EEF7"];
  Clock [label="Clock / Reset\nXTAL, 74LS04", fillcolor="#E8F1E7"];
  Latch [label="Address Latch\n74LS373", fillcolor="#FBE9D0"];
  CPU [label="8085A CPU", fillcolor="#F6E7D8"];
  Buffer [label="Data Buffer\n74LS245", fillcolor="#FBE9D0"];
  Decode [label="Coarse Decode\n74LS138", fillcolor="#EFE3F8"];
  Power [label="Power Bulk\n+5V / GND lane", fillcolor="#F7F3E8"];
  BottomEdgeA [label="Bottom Edge\nConnector / Bus Out", fillcolor="#E7EEF7"];

  Top -> Clock;
  Top -> Latch;
  Top -> CPU;
  Top -> Buffer;
  Top -> Decode;
  Clock -> CPU;
  Latch -> CPU;
  CPU -> Buffer;
  CPU -> Decode;
  Power -> CPU;
  CPU -> BottomEdgeA;
  Buffer -> BottomEdgeA;
  Decode -> BottomEdgeA;
}
''',
    "RodneyBoardB": COMMON + r'''
  rankdir=TB;

  node [shape=record];

  Top [label="Top Edge\nMemory Test Points", fillcolor="#E7EEF7"];
  Main [label="62256\nMain Memory", fillcolor="#FBE9D0"];
  Dec [label="Decode\n74LS138 / 74LS139", fillcolor="#EFE3F8"];
  MMA [label="MMA Latches\nLow / High", fillcolor="#F6E7D8"];
  MMD [label="MMD Path", fillcolor="#F6E7D8"];
  PRG [label="6264\nProgram RAM", fillcolor="#E8F1E7"];
  ROM [label="EEPROM /\nMonitor ROM", fillcolor="#E8F1E7"];
  Power [label="Power Bulk\n+5V / GND lane", fillcolor="#F7F3E8"];
  BottomEdgeB [label="Bottom Edge\nConnector / Bus In", fillcolor="#E7EEF7"];

  Top -> Main;
  BottomEdgeB -> Dec;
  Dec -> PRG;
  Dec -> ROM;
  Dec -> MMA;
  MMA -> Main;
  MMD -> Main;
  PRG -> BottomEdgeB;
  ROM -> BottomEdgeB;
  Main -> BottomEdgeB;
  Power -> Main;
}
''',
    "RodneyBoardC": COMMON + r'''
  rankdir=TB;

  node [shape=record];

  Top [label="Top Edge\nI/O Test Points / Jumpers", fillcolor="#E7EEF7"];
  TSWR [label="TSWR\nLFSR / Random", fillcolor="#EFE3F8"];
  ENVL [label="ENVL DIP\nSwitches", fillcolor="#E8F1E7"];
  ENVH [label="ENVH DIP\nOptional", fillcolor="#E8F1E7"];
  INBUF [label="Input Buffer", fillcolor="#FBE9D0"];
  OUTLAT [label="Output Latch", fillcolor="#FBE9D0"];
  ACTL [label="ACTL LEDs", fillcolor="#F6E7D8"];
  ACTH [label="ACTH LEDs\nOptional", fillcolor="#F6E7D8"];
  Dec [label="Local Decode", fillcolor="#EFE3F8"];
  Power [label="Power Bulk\n+5V / GND lane", fillcolor="#F7F3E8"];
  BottomEdgeC [label="Bottom Edge\nConnector / Bus In", fillcolor="#E7EEF7"];

  Top -> TSWR;
  Top -> ENVL;
  Top -> ENVH;
  ENVL -> INBUF;
  ENVH -> INBUF;
  TSWR -> INBUF;
  BottomEdgeC -> Dec;
  Dec -> INBUF;
  Dec -> OUTLAT;
  OUTLAT -> ACTL;
  OUTLAT -> ACTH;
  Power -> OUTLAT;
}
''',
    "RodneySelfProgrammingPath": COMMON + r'''
  rankdir=LR;

  ENVL [label="ENVL\nSwitches / Sensors", fillcolor="#E8F1E7"];
  CPU [label="8085A\nBeta / Gamma Runtime", fillcolor="#FBE9D0"];
  MMA [label="MMA Low / High\nIndirect Address", fillcolor="#F6E7D8"];
  MEM [label="Main Memory\nLearned State Table", fillcolor="#EFE3F8"];
  MMD [label="MMD\nData Path", fillcolor="#E7EEF7"];
  ACTL [label="ACTL\nAction Output", fillcolor="#F7D9D9"];

  ENVL -> CPU [label="current state"];
  CPU -> MMA [label="select entry"];
  MMA -> MEM [label="address"];
  MEM -> MMD [label="learned byte"];
  MMD -> CPU [label="read / write"];
  CPU -> ACTL [label="response nibble"];
  CPU -> MMD [label="store\nresponse/confidence"];
}
''',
}


def render(name: str, dot_source: str) -> None:
    dot_path = ROOT / f"{name}.dot"
    pdf_path = ROOT / f"{name}.pdf"
    jpg_path = ROOT / f"{name}.jpg"
    dot_path.write_text(dot_source, encoding="ascii")
    subprocess.run(
        ["dot", "-Tpdf", str(dot_path), "-o", str(pdf_path)],
        check=True,
    )
    subprocess.run(
        ["dot", "-Tjpg", str(dot_path), "-o", str(jpg_path)],
        check=True,
    )


def main() -> None:
    for name, dot_source in DIAGRAMS.items():
        render(name, dot_source)


if __name__ == "__main__":
    main()
