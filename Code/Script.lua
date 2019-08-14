local orig_print = print
if Mods.mrudat_TestingMods then
  print = orig_print
else
  print = empty_func
end

local CurrentModId = rawget(_G, 'CurrentModId') or rawget(_G, 'CurrentModId_X')
local CurrentModDef = rawget(_G, 'CurrentModDef') or rawget(_G, 'CurrentModDef_X')
if not CurrentModId then

  -- copied shamelessly from Expanded Cheat Menu
  local Mods, rawset = Mods, rawset
  for id, mod in pairs(Mods) do
    rawset(mod.env, "CurrentModId_X", id)
    rawset(mod.env, "CurrentModDef_X", mod)
  end

  CurrentModId = CurrentModId_X
  CurrentModDef = CurrentModDef_X
end

orig_print("loading", CurrentModId, "-", CurrentModDef.title)

local function AddBuildingToTech (building_id, tech_id, hide_building)
  local requirements = BuildingTechRequirements[building_id] or {}
  BuildingTechRequirements[building_id] = requirements
  for _, requirement in ipairs(requirements) do
    if requirement.tech == tech_id then
      requirement.hide = hide_building
      return
    end
  end
  requirements[#requirements + 1] = { tech = tech_id, hide = hide_building }
end

function OnMsg.ClassesPreprocess()
  AddBuildingToTech("FlourMill", "MartianVegetation")
end

orig_print("loaded", CurrentModId, "-", CurrentModDef.title)
