---@meta

---@class PaneSplitParams
---@field public args table<string>
---@field public cwd string
---@field public set_environment_variables table<string, string>
---@field public domain string|table<string, string>
---@field public direction "Right"|"Left"|"Top"|"Bottom"
---@field public top_level boolean
---@field public size number

---@class Pane
---@field activate fun(self: Pane): nil Activates (focuses) the pane and its containing tab.
---@field get_current_working_dir fun(self: Pane): Url Returns the current working directory of the pane, if known. The current directory can be specified by an application sending OSC 7.
---@field get_cursor_position fun(self: Pane): StableCursorPosition Returns a lua representation of the StableCursorPosition struct that identifies the cursor position, visibility and shape.
---@field get_dimensions fun(self: Pane): RenderableDimensions Returns a lua representation of the RenderableDimensions struct that identifies the dimensions and position of the viewport as well as the scrollback for the pane.
---@field get_domain_name fun(self: Pane): string Returns the name of the domain with which the pane is associated.
---@field get_foreground_process_info fun(self: Pane): LocalProcessInfo Returns a LocalProcessInfo object corresponding to the current foreground process that is running in the pane.
---@field get_foreground_process_name fun(self: Pane): string Returns the path to the executable image for the pane.
---@field get_lines_as_text fun(self: Pane, lines: number?): string Returns the textual representation (not including color or other attributes) of the physical lines of text in the viewport as a string. A physical line is a possibly-wrapped line that composes a row in the terminal display matrix. If you'd rather operate on logical lines, see pane:get_logical_lines_as_text. If the optional nlines argument is specified then it is used to determine how many lines of text should be retrieved. The default (if nlines is not specified) is to retrieve the number of lines in the viewport (the height of the pane). The lines have trailing space removed from each line. The lines will be joined together in the returned string separated by a \n character. Trailing blank lines are stripped, which may result in fewer lines being returned than you might expect if the pane only had a couple of lines of output.
---@field get_logical_lines_as_text fun(self: Pane, lines: number?): string Returns the textual representation (not including color or other attributes) of the logical lines of text in the viewport as a string. A logical line is an original input line prior to being wrapped into physical lines to composes rows in the terminal display matrix. WezTerm doesn't store logical lines, but can recompute them from metadata stored in physical lines. Excessively long logical lines are force-wrapped to constrain the cost of rewrapping on resize and selection operations. If you'd rather operate on physical lines, see pane:get_lines_as_text. If the optional nlines argument is specified then it is used to determine how many lines of text should be retrieved. The default (if nlines is not specified) is to retrieve the number of lines in the viewport (the height of the pane). The lines have trailing space removed from each line. The lines will be joined together in the returned string separated by a \n character. Trailing blank lines are stripped, which may result in fewer lines being returned than you might expect if the pane only had a couple of lines of output.
---@field get_metadata fun(self: Pane): PaneMetadata? Returns metadata about a pane. The return value depends on the instance of the underlying pane. If the pane doesn't support this method, nil will be returned. Otherwise, the value is a lua table with the metadata contained in table fields.
---@field get_semantic_zone_at fun(self: Pane): any TODO
---@field get_semantic_zones fun(self: Pane): any TODO
---@field get_text_from_region fun(self: Pane, start_x: number, start_y: number, end_x: number, end_y: number): string Returns the text from the specified region.
---@field get_text_from_semantic_zone fun(self: Pane): any TODO
---@field get_title fun(self: Pane): string Returns the title of the pane. This will typically be wezterm by default but can be modified by applications that send OSC 1 (Icon/Tab title changing) and/or OSC 2 (Window title changing) escape sequences. The value returned by this method is the same as that used to display the tab title if this pane were the only pane in the tab; if OSC 1 was used to set a non-empty string then that string will be returned. Otherwise the value for OSC 2 will be returned. Note that on Microsoft Windows the default behavior of the OS level PTY is to implicitly send OSC 2 sequences to the terminal as new programs attach to the console. If the title text is wezterm and the pane is a local pane, then wezterm will attempt to resolve the executable path of the foreground process that is associated with the pane and will use that instead of wezterm.
---@field get_tty_name fun(self: Pane): string? Returns the tty device name, or nil if the name is unavailable.
---@field get_user_vars fun(self: Pane): { [string]: string } Returns a table holding the user variables that have been assigned to this pane. User variables are set using an escape sequence defined by iterm2, but also recognized by wezterm; this example sets the foo user variable to the value bar:
---@field has_unseen_output fun(self: Pane): boolean Returns true if there has been output in the pane since the last time the time the pane was focused.
---@field inject_output fun(self: Pane, text: string): nil Sends text, which may include escape sequences, to the output side of the current pane. The text will be evaluated by the terminal emulator and can thus be used to inject/force the terminal to process escape sequences that adjust the current mode, as well as sending human readable output to the terminal. Note that if you move the cursor position as a result of using this method, you should expect the display to change and for text UI programs to get confused. Not all panes support this method; at the time of writing, this works for local panes but not for multiplexer panes.
---@field is_alt_screen_active fun(self: Pane): boolean Returns whether the alternate screen is active for the pane. The alternate screen is a secondary screen that is activated by certain escape codes. The alternate screen has no scrollback, which makes it ideal for a "full-screen" terminal program like vim or less to do whatever they want on the screen without fear of destroying the user's scrollback. Those programs emit escape codes to return to the normal screen when they exit.
---@field move_to_new_tab fun(self: Pane): { tab: MuxTabObj, window: MuxWindow } Creates a new tab in the window that contains pane, and moves pane into that tab. Returns the newly created MuxTab object, and the MuxWindow object that contains it.
---@field move_to_new_window fun(self: Pane, workspace: string?): { tab: MuxTabObj, window: MuxWindow } Creates a window and moves pane into that window. The WORKSPACE parameter is optional; if specified, it will be used as the name of the workspace that should be associated with the new window. Otherwise, the current active workspace will be used. Returns the newly created MuxTab object, and the newly created MuxWindow object.
---@field mux_pane fun(self: Pane): nil **DEPRECATED**
---@field pane_id fun(self: Pane): number Returns the id number for the pane. The Id is used to identify the pane within the internal multiplexer and can be used when making API calls via wezterm cli to indicate the subject of manipulation.
---@field paste fun(self: Pane, text: string): nil Sends the supplied text string to the input of the pane as if it were pasted from the clipboard, except that the clipboard is not involved. If the terminal attached to the pane is set to bracketed paste mode then the text will be sent as a bracketed paste. Otherwise the string will be streamed into the input in chunks of approximately 1KB each.
---@field send_paste fun(self: Pane, text: string): nil Sends text to the pane as though it was pasted. If bracketed paste mode is enabled then the text will be sent as a bracketed paste. Otherwise, it will be sent as-is.
---@field send_text fun(self: Pane, text: string): nil Sends text to the pane as-is.
---@field split fun(self: Pane, params: PaneSplitParams): Pane Splits pane and spawns a program into the split, returning the Pane object associated with it
---@field tab fun(self: Pane): MuxTabObj? the MuxTab that contains this pane. Note that this method can return nil when pane is a GUI-managed overlay pane (such as the debug overlay), because those panes are not managed by the mux layer.
---@field window fun(self: Pane): MuxWindow Returns the MuxWindow that contains the tab that contains this pane.
