const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#0B1118", /* black   */
  [1] = "#5E535B", /* red     */
  [2] = "#A56046", /* green   */
  [3] = "#9A6C60", /* yellow  */
  [4] = "#B7866C", /* blue    */
  [5] = "#D29674", /* magenta */
  [6] = "#777285", /* cyan    */
  [7] = "#e1cec2", /* white   */

  /* 8 bright colors */
  [8]  = "#9d9087",  /* black   */
  [9]  = "#5E535B",  /* red     */
  [10] = "#A56046", /* green   */
  [11] = "#9A6C60", /* yellow  */
  [12] = "#B7866C", /* blue    */
  [13] = "#D29674", /* magenta */
  [14] = "#777285", /* cyan    */
  [15] = "#e1cec2", /* white   */

  /* special colors */
  [256] = "#0B1118", /* background */
  [257] = "#e1cec2", /* foreground */
  [258] = "#e1cec2",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
