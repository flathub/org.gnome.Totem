# Videos


This manifest gets released through Flathub and includes:

- all the dependencies to compile Videos itself, on top of the GNOME runtime
- a completely separate codecs stack with DVD support, recent ffmpeg and GStreamer
  releases to be able to choose to support video formats that would not make sense
  in other desktop components
- DLNA support through the dleyna project

## Bug reporting

Before reporting a bug, please double-check whether the problem occurs with the
[development release of Videos](https://github.com/flathub/org.gnome.Totem.Devel/).

It can be installed by running:
```sh
flatpak install --user https://flathub.org/beta-repo/appstream/org.gnome.Totem.Devel.flatpakref
```

The application should appear as *Videos Preview*.

## Contributing changes

Unless changes are only applicable to the stable version of the application, please
contribute those changes to the [preview version](https://github.com/flathub/org.gnome.Totem.Devel/pulls) first.
