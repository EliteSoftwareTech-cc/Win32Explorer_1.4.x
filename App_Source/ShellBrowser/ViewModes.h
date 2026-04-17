// Copyright (C) Win32Explorer Project
// SPDX-License-Identifier: GPL-3.0-only
// See LICENSE in the top level directory

#pragma once

#include "../Shared_Libraries/BetterEnumsWrapper.h"

class ResourceLoader;
struct Config;

// clang-format off
BETTER_ENUM(ViewMode, int,
	Icons = 1,
	SmallIcons = 2,
	List = 3,
	Details = 4,
	Tiles = 5,
	Thumbnails = 6,
	ExtraLargeIcons = 7,
	LargeIcons = 8,
	ExtraLargeThumbnails = 9,
	LargeThumbnails = 10
)
// clang-format on

bool IsThumbnailsViewMode(ViewMode viewMode, const Config *config = nullptr);

UINT GetViewModeMenuId(ViewMode viewMode);
std::wstring GetViewModeMenuText(const ResourceLoader *resourceLoader, ViewMode viewMode);


