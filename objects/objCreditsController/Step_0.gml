
if (credits_timer > 0) {
    credits_timer--;
    if (credits_timer <= 0) {
        allow_skip = true;
    }
}


if (allow_skip && !global.midTransition) {
    if (objInputManager.pressed.space || objInputManager.pressed.enter) {
        SoundPlay(sfxUIClick);
        TransitionStart(rmMainMenu, sqFadeOut, sqFadeIn, 0, 0, GameStatePaused);
    }
}
