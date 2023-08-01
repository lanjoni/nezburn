# nezburn-theme

[![License: AGPL v3](https://img.shields.io/badge/License-AGPL_v3-blue.svg)](https://www.gnu.org/licenses/agpl-3.0)
[![MELPA](http://melpa.org/packages/nezburn-theme-badge.svg)](http://melpa.org/#/nezburn-theme)

The nezburn theme (inspired on zenburn) for Emacs. Very cool.

## Description

The theme is directly inspired by the [zenburn theme for Emacs](https://github.com/bbatsov/zenburn-emacs/tree/master), based on its composition, in addition to receiving color tones inspired by the [Pale Fire theme](https://github.com/matklad/pale-fire).

Its composition includes simple colors for a better reuse of tones. The theme is necessarily a theme geared towards using the dark development environment.

![Sample screenshot of nezburn-theme](screenshots/screenshot.png)

## Installing

### Manual

Download `nezburn-theme.el` to the directory `~/.emacs.d/themes/`. Add this to your `init.el` file or another configuration file for your visual workflow:

```el
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
```
> This will be responsible for referencing files inside the `.emacs.d/themes` directory to be initialized along with your configuration.

### Package.el

Nezburn is available in [MELPA](http://melpa.org). You can install `nezburn` with `M-x package-install nezburn-theme`!

To load it automatically on Emacs startup add this to your init file:

```el
(load-theme 'nezburn t)
```
> This way works normally too.

## Authors

Contributors names and contact info
- [@lanjoni](https://twitter.com/gutolanjoni)

## Version History

* 0.1
    * Initial Release

## License

This project is licensed under the AGPL 3.0 License - see the LICENSE.md file for details
