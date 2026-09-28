static const char norm_fg[] = "#e1cec2";
static const char norm_bg[] = "#0B1118";
static const char norm_border[] = "#9d9087";

static const char sel_fg[] = "#e1cec2";
static const char sel_bg[] = "#A56046";
static const char sel_border[] = "#e1cec2";

static const char urg_fg[] = "#e1cec2";
static const char urg_bg[] = "#5E535B";
static const char urg_border[] = "#5E535B";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
