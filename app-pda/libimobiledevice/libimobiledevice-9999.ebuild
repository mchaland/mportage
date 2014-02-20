# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libimobiledevice/libimobiledevice-1.1.5.ebuild,v 1.5 2013/11/24 18:48:43 ago Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )
inherit eutils python-r1 multilib git-2

DESCRIPTION="Support library to communicate with Apple iPhone/iPod Touch devices"
HOMEPAGE="http://www.libimobiledevice.org/"
EGIT_REPO_URI="https://github.com/libimobiledevice/libimobiledevice.git"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0/4"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 x86"
IUSE="gnutls python"

RDEPEND=">=app-pda/libplist-1.10[python?,${PYTHON_USEDEP}]
	app-pda/libusbmuxd
	gnutls? (
		dev-libs/libgcrypt
		>=dev-libs/libtasn1-1.1
		>=net-libs/gnutls-2.2.0
		)
	!gnutls? ( dev-libs/openssl:0 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	python? (
		${PYTHON_DEPS}
		>=dev-python/cython-0.17[${PYTHON_USEDEP}]
		)"

DOCS=( AUTHORS NEWS README )

pkg_setup() {
	# Prevent linking to the installed copy
	if has_version "<${CATEGORY}/${P}"; then
		rm -f "${EROOT}"/usr/$(get_libdir)/${PN}$(get_libname)
	fi
}

src_configure() {
	use python && python_export_best

	local myconf
	use gnutls && myconf='--disable-openssl'
	use python || myconf+=' --without-cython'

	./autogen.sh --prefix=/usr --disable-static ${myconf}
}

src_install() {
	default

	prune_libtool_files --all
}
