# CHEATSHEET

Leader: `Space`  ·  LocalLeader: `\`

## EDITING

    A-k / A-j     Move line up / down
    A-h / A-l     Unindent / indent
                  (n, i and v modes)

    d D x X       Delete, never yanks
    <leader>x     Cut (operator)
    <leader>xx    Cut line
    p  (visual)   Paste, keep register
    J             Join, keep cursor

## NAVIGATION

    H / L         Line start / end
    C-d / C-u     Half page, centered
    n / N         Search result, centered
    C-o / C-i     Jumplist back / forward

## WINDOWS

    C-h j k l     Move between splits
    C-S-h j k l   Resize split
    <leader>i     Split vertical
    <leader>-     Split horizontal
    <leader>BS    Close split
    <leader>m     Equalize splits

## BUFFERS

    Tab           Alternate buffer
    A-1 .. A-0    Go to buffer 1..10
    A-BS          Close buffer
    :W            Write and close buffer

## EXPLORER

    <leader>e     Toggle sidebar
    <leader>E     Collapse all

  Inside the tree:

    CR / l        Open (auto: editor or system)
    \             Preview
    i / -         Open in vsplit / split
    s / S         Force system / editor
    h / BS        Close directory
    [ / ]         Root up / down
    a d r         Create, delete, rename
    x c p         Cut, copy, paste
    y             Copy absolute path
    H             Toggle hidden
    f / F         Filter / clear filter

## FIND (Telescope)

    <leader>ff    Files
    <leader>fg    Grep contents
    <leader>fw    Grep word under cursor
    <leader>fb    Buffers
    <leader>fr    Recent files
    <leader>fs    Resume last search
    <leader>fo    Document symbols
    <leader>fk    Search keymaps

## LSP

    ?  (or K)     Hover docs
    C-s           Signature help (insert)
    grd           Definition
    grt           Type definition
    gri           Implementation
    grr           References
    grn           Rename symbol
    gra           Code action
    <leader>lf    Format buffer

  Format also runs on save.
  Signature help pops up on ( and ,

## DIAGNOSTICS

    <leader>qq    Show under cursor
    <leader>ql    List all
    <leader>qv    Toggle virtual text
    [d / ]d       Previous / next error

  Gutter: x error, ! warn, i info, ? hint
  Jumps only stop on errors.

## GIT

    ]c / [c       Next / previous hunk
    <leader>gp    Preview hunk
    <leader>gb    Blame line (full)
    <leader>gt    Toggle inline blame

  Tree colors: green new, yellow dirty,
  cyan staged, red deleted, grey ignored.

## COMPLETION (insert)

    C-j / C-k     Next / previous item
    Tab           Accept, or snippet jump
    S-Tab         Snippet jump back
    CR            Accept
    Esc           Dismiss menu
    C-Space       Trigger manually
    C-b / C-f     Scroll docs

## FILE BROWSER (normal mode)

    j / k         Move
    h             Parent directory
    l / CR        Enter or open
    H             Toggle hidden
    a             Create (end with / for dir)
    d r           Delete, rename
    y x           Copy, move
    . / ~         Go to cwd / home

## DASHBOARD

    a             New file
    f             File explorer
    r             Recent files
    c             Configuration
    q             Quit

## COMMANDS

    :W            Write and close buffer
    :ThemeReload  Reapply theme from palette

## MISC

    <leader>ch    Toggle this cheatsheet

  Search highlight clears itself on any
  key that is not n N * # /
