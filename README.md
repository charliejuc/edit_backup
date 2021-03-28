# EDIT BACKUP
Copy before editing a file to avoid loss of information.

## Setup
### Environment variables
- EDITOR_BACKUP_PATH (default: /tmp)
- EDITOR (Preferred editor: vim, nano...)

### Alias
After copying the repository I recommend creating an alias with your preferred editor, in my case, vim:

```bash
alias vim="EDITOR=vim <CLONED_REPO_PATH>/edit.sh"
```

From now on when we edit a file with vim, that is going to be saved in "EDITOR_BACKUP_PATH"
inside "edit_backup_< USERNAME >" folder.

**WARNING RUNNING WITH SUDO:** Remember to set environment variables for
root user or use "sudo -E" to keep the current user environment.
