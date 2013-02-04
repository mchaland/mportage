EAPI=4

DESCRIPTION="A FUSE filesystem providing access to MTP devices"
HOMEPAGE="http://research.jacquette.com/jmtpfs-exchanging-files-between-android-devices-and-linux/"
SRC_URI="http://research.jacquette.com/wp-content/uploads/2012/05/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=media-libs/libmtp-1.1.0
	>=sys-fs/fuse-2.6"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9.0"

DOCS=(AUTHORS NEWS README)

src_configure() {
	econf
}

pkg_postinst() {
	einfo "To mount your MTP device, issue:"
	einfo "    /usr/bin/jmtpfs <mountpoint>"
	echo
	einfo "To unmount your MTP device, issue:"
	einfo "    /usr/bin/fusermount -u <mountpoint>"
}
