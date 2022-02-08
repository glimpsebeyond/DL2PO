DL2notes

#TODO {
Why doesn't prone ragdoll get behaviors?

Change ai\damage_rules.scr
    Rule("stamina_depleted_melee_weapon_blunt_light_inflicts_unstable");
    Rule("stamina_depleted_melee_weapon_blunt_medium_inflicts_unstable");
    unstable is probably not a ragdoll and not as fun
}

# general{

You CANNOT nest /* */ comments

# animation
ai_timing.def
    $EVENT_FALL_FROM_EDGE_ENABLED       (i, 102)
}
characters\animations\animscripts\pinhead\biter.scr
    seems to define hit reaction animations

EVENT_FORCE_FALL causes ragdoll?
characters\animations\animscripts\pinhead\viral.scr
    All EVENT_FORCE_FALL commented out


#weapon{
scripts\inventory\inventory_special.scr
    Defines Melee_Fists, the player fists

}

# ragdoll
ai\ai_lod_policy.scr
    MaxActiveAIRagdolls

ragdoll_behaviors.def defines variables for .phx
ragdoll_behaviors.phx defines behaviors for ragdoll .scr scripts to use

ragdoll_behavior_rules.scr
Links reaction attributes to RagdollBehaviorPresets in ai_ragdoll_behavior_presets.scr
    Data(EReactionType_Cut, EReactionContext_MeleeWeapon, EHitSeverity_Any, EMoveSeverity_Any,
    ERagdollHitPart_Head, EImpactDirection_Left,
    "cut_melee_weapon_UB_left@ai_ragdoll_behavior_presets.scr");

ragdoll_behaviors.phx
Defines Behaviors using various dynamics like
    Behavior("TorsoVertical1_Down")
    {
        LinVel(0, 0.15, 12.5, CURVE_CONST, "neck1", "", [-0.3, -1, 1], COORD_START)
vector3 with COORD_START for [x, y, z] where hit occurs right side
    +x toward player
    -x toward player
    +y up
    -y down
    +z left of player (same direction as swing)
    -z right of player (opposite direction of swing)
    z tends to be the most important axis with COORD_START
COORD_WORLD 
    +x 
    -x
    +y up
    -y down
    +z
    -z
COORD_LOCAL on "spine3"
    Assuming spine 3 goes up from pelvis (bone tip is up)
    +x toward bone tip (initially up if zombie standing)
    -x away from bone tip (initially down if zombie standing)
    +y zombie's left
    -y zombie's right
    +z zombie's back
    -z zombie's front
AngVel(0, 10.0, 50, CURVE_CONST, "spine3", "", [1, 0, 0], COORD_LOCAL)
    Assuming spine 3 goes up from pelvis
    +x 
    -x
    +y
    -y
    +z
    -z
RandLinImpulse
    With start = 0.5 and end = 0.5, setting impulse to 0.5 will impulse exactly 1 time


  ai_ragdoll_behavior_presets.scr 
    Defines RagdollBehaviorPresets using behaviors from ragdoll_behaviors.phx
    These presets are applied at death and maybe other ragdolls

  ai_ragdoll_behavior_params.scr 
  damage_does_not_trigger_ragdoll_after_death

damage
    damage_reaction_presets.scr
            SReactionData("light_collision")
        {
            type(EReactionType_Push);
            context(EReactionContext_Collision);
            hit_severity(EHitSeverity_Light);
            move_severity(EMoveSeverity_Light);
            flags(EReactionFlag_Interrupt);
        }

CheatMenu stuff in debugconf.def
curve_di.xml has stuff like infected_melee_dodge_prob and infected_turn_speed
bone_names.scr