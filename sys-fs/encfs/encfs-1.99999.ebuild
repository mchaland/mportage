# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/encfs/encfs-1.7.4.ebuild,v 1.6 2012/10/31 23:14:20 flameeyes Exp $

EAPI=2
inherit git-2 autotools eutils multilib

DESCRIPTION="An implementation of encrypted filesystem in user-space using FUSE"
HOMEPAGE="http://www.arg0.net/encfs/"
#ESVN_REPO_URI="http://encfs.googlecode.com/svn/branches/1.x"
EGIT_REPO_URI="https://github.com/vgough/encfs.git"
EGIT_BRANCH="1.x"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE="xattr"

RDEPEND=">=dev-libs/boost-1.34
	>=dev-libs/openssl-0.9.7
	>=dev-libs/rlog-1.4
	>=sys-fs/fuse-2.7.0
	sys-libs/zlib"
DEPEND="${RDEPEND}
	dev-lang/perl
	virtual/pkgconfig
	xattr? ( sys-apps/attr )
	sys-devel/gettext"

src_prepare() {
	epatch "${FILESDIR}/encfs-1.99999-fix-pod.patch"
	eautoreconf
}

src_configure() {
	use xattr || export ac_cv_header_attr_xattr_h=no

	econf \
		--disable-dependency-tracking
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README
	find "${D}" -name '*.la' -delete
}
