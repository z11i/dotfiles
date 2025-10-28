# Home Manager Quick Reference

## Basic Operations

### Apply Configuration Changes
After editing `home.nix`, apply the changes:
```bash
home-manager switch --flake .#z11i
```

Or from anywhere:
```bash
home-manager switch --flake ~/.dotfiles/home-manager#z11i
```

### Update Inputs (Packages)
Update nixpkgs and home-manager to latest versions:
```bash
nix flake update
```

Then apply:
```bash
home-manager switch --flake .#z11i
```

### Check Configuration
Test configuration without applying:
```bash
home-manager build --flake .#z11i
```

### List Generations
See all home-manager generations:
```bash
home-manager generations
```

### Rollback
Rollback to previous generation:
```bash
home-manager switch --flake .#z11i --rollback
```

Or switch to specific generation:
```bash
/nix/store/[generation-path]/activate
```

### Clean Old Generations

#### Home Manager (Flake-based)
Remove old generations older than 7 days:
```bash
home-manager expire-generations "-7 days"
```

Or remove all old generations:
```bash
home-manager expire-generations "-0 days"
```

#### Legacy nix-env Profiles
If you previously used nix-env, clean those too:
```bash
# List current generations
nix-env --list-generations

# Delete old generations (keeps current)
nix-env --delete-generations old

# Or delete by age
nix-env --delete-generations 7d
```

#### Garbage Collection
After expiring generations, collect garbage:
```bash
# Standard garbage collection
nix-collect-garbage

# More aggressive - also removes old profile generations
nix-collect-garbage -d

# Alternative command (same as above)
nix store gc

# See how much space you'll free (dry run)
nix store gc --dry-run
```

#### Complete Cleanup (All-in-one)
```bash
home-manager expire-generations "-0 days" && nix-env --delete-generations old && nix-collect-garbage -d
```

## Configuration Files

- **flake.nix**: Defines inputs (nixpkgs, home-manager) and outputs
- **home.nix**: Your main configuration file for packages, programs, and settings
- **flake.lock**: Lock file tracking exact versions of inputs

## Common Tasks

### Add a Package
Edit `home.nix` and add to `home.packages`:
```nix
home.packages = with pkgs; [
  ripgrep
  # ... other packages
];
```

Then run:
```bash
home-manager switch --flake .#z11i
```

### Configure a Program
Edit `home.nix`:
```nix
programs.git = {
  enable = true;
  userName = "Your Name";
  userEmail = "your@email.com";
};
```

### Search for Packages
```bash
nix search nixpkgs <package-name>
```

## Tips

- Always commit your changes to git after successful switches
- Use `nix flake update` regularly to get latest packages
- Keep old generations around for a while in case you need to rollback
- Check the [Home Manager manual](https://nix-community.github.io/home-manager/) for available options

## Your Setup

- **System**: aarch64-darwin (Apple Silicon Mac)
- **User**: z11i
- **Channel**: nixos-unstable
- **Config Location**: ~/.dotfiles/home-manager
