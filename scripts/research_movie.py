#!/usr/bin/env python3
"""Select the pinned movie used by the legacy research workflow."""

from __future__ import annotations

import argparse
from pathlib import Path


MOVIES = {"tas", "longplay", "menus"}


def selected_movie(marker: Path) -> str:
    if not marker.is_file():
        raise ValueError(f"movie marker not found: {marker}; run make set-movie first")
    movie = marker.read_text(encoding="utf-8").strip()
    if movie not in MOVIES:
        raise ValueError(f"{marker}: unknown movie {movie!r}")
    return movie


def report_for_movie(marker: Path) -> Path:
    return marker.parent / f"analysis_report_{selected_movie(marker)}.csv"


def set_movie(marker: Path, movie: str) -> None:
    if movie not in MOVIES:
        raise ValueError(f"unknown movie {movie!r}; choose tas, longplay or menus")
    marker.parent.mkdir(parents=True, exist_ok=True)
    marker.write_text(movie + "\n", encoding="utf-8")


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("action", choices=("set", "show"))
    parser.add_argument("--marker", default="workflow/.movie")
    parser.add_argument("--movie", default="")
    args = parser.parse_args(argv)

    marker = Path(args.marker)
    try:
        if args.action == "set":
            set_movie(marker, args.movie)
            print(f"Movie type set to: {args.movie} ({marker})")
        else:
            print(f"Current movie: {selected_movie(marker)}")
    except ValueError as error:
        parser.error(str(error))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
