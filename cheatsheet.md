# CHEATSHEET

Leader: `Space`  ·  LocalLeader: `\`

## EDITING

    A-k / A-j     Move line up / down
    A-h / A-l     Unindent / indent
                  (works in n, i, v)

    d D x X       Delete (never yanks)
    <leader>x     Cut (operator)
    <leader>xx    Cut line
    p  (visual)   Paste, keep register
    J             Join, keep cursor

## NAVIGATION

    H / L         Line start / end
    C-d / C-u     Half page, centered
    n / N         Search result, centered
    C-o / C-i     Jumplist back / forward
    Tab           Alternate buffer

## WINDOWS

    C-h j k l     Move between splits
    C-S-h j k l   Resize split
    <leader>i     Split vertical
    <leader>-     Split horizontal
    <leader>BS    Close split
    <leader>m     Equalize splits

## BUFFERS

    A-1 .. A-0    Go to buffer 1..10
    Tab           Alternate buffer
    A-BS          Close buffer
    :W            Write + close buffer

## EXPLORER

    <leader>e     Toggle sidebar
    <leader>E     Collapse all

  Inside the tree:

    CR            Open (auto: editor/system)
    \             Preview
    i / -         Open in vsplit / split
    s / S         Force system / editor
    BS            Close directory
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

  Format runs automatically on save.

## DIAGNOSTICS

    <leader>qq    Show under cursor
    <leader>ql    List all
    <leader>qv    Toggle virtual text
    [d / ]d       Previous / next error

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

## MISC

    <leader>ch    Toggle this cheatsheet

  Search highlight clears automatically
  on any key that is not n N * # /
