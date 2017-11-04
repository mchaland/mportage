# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/tint2/tint2-0.11-r1.ebuild,v 1.5 2012/09/11 17:38:41 idl0r Exp $

EAPI=6

inherit cmake-utils eutils git-r3

DESCRIPTION="A lightweight panel/taskbar with graphics"
HOMEPAGE="http://code.google.com/p/tint2/"
EGIT_REPO_URI="https://github.com/mchaland/tint2-graph.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="battery examples tint2conf"

COMMON_DEPEND="dev-libs/glib:2
	x11-libs/cairo
	x11-libs/pango[X]
	x11-libs/libX11
	x11-libs/libXinerama
	x11-libs/libXdamage
	x11-libs/libXcomposite
	x11-libs/libXrender
	x11-libs/libXrandr
	media-libs/imlib2[X]"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
	x11-proto/xineramaproto"
RDEPEND="${COMMON_DEPEND}
	tint2conf? ( x11-misc/tintwizard )"

src_prepare() {
	epatch "${FILESDIR}/gtk-icon-cache.sandbox.patch"
	eapply_user
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_BATTERY="$(usex battery)"
		-DENABLE_EXAMPLES="$(usex examples)"
		-DENABLE_TINT2CONF="$(usex tint2conf)"

		# bug 296890
		"-DDOCDIR=/usr/share/doc/${PF}"
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	rm -f "${D}/usr/bin/tintwizard.py"
}
