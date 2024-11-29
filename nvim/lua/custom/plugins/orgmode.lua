return {
  'nvim-orgmode/orgmode',
  ft = { 'org' },
  config = function()
    -- Setup orgmode
    require('orgmode').setup {
      org_agenda_files = {
        '~/Sync/org/gtd/inbox.org',
        '~/Sync/org/gtd/gtd.org',
        '~/Sync/org/gtd/tickler.org',
      },
      org_default_notes_file = '~/Sync/org/gtd/inbox.org',
    }
  end,
}
