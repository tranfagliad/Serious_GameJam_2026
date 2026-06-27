
draw_set_font(fntConsolMassive);
draw_set_halign(fa_center)

draw_set_font(fntConsolYouDied);
draw_text(VIEWPORT_WIDTH/2, 20, "Dev Team");
draw_set_halign(fa_left);

draw_set_font(fntConsolMassive);
draw_set_colour(c_blue);
draw_text(300, 120, "Programmers");
draw_set_colour(c_maroon);
draw_text(300, 250, "Artists");
draw_set_colour(c_purple);
draw_text(300, 380, "Music / SFX");
draw_set_colour(c_green);
draw_text(300, 500, "Support");
draw_set_colour(c_white);

draw_set_font(fntConsolBig)
draw_text(340, 160, "Kazak");
draw_text(340, 190, "rocket176");

draw_text(340, 290, "design_burrito            Environments, UI, HUD");
draw_text(340, 320, "Dreamy                    Character Design & Animations");

draw_text(340, 420, "stedema");

draw_text(340, 540, "extonjunior               Production Support & Team Coordination");
draw_text(340, 570, "CarbonFire                Level Design & Dialogue");



if (allow_skip) {
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_bottom);
    draw_text(VIEWPORT_WIDTH / 2, VIEWPORT_HEIGHT - 25, "Press [SPACE] to return to Title Screen");
}
