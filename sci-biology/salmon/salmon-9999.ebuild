# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib cmake-utils git-r3

DESCRIPTION="Transcript-level quantification from RNA-seq reads using lightweight alignments"
HOMEPAGE="https://github.com/COMBINE-lab/salmon"
EGIT_REPO_URI="https://github.com/COMBINE-lab/salmon.git"

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="dev-libs/boost:0
		dev-libs/jemalloc
		>=dev-cpp/tbb-2018.20180312"
RDEPEND="${DEPEND}"
# https://github.com/COMBINE-lab/salmon/issues/19
#
# contains bundled copies of https://github.com/jemalloc/jemalloc
# https://github.com/gabime/spdlog
# https://github.com/efficient/libcuckoo
# https://github.com/greg7mdp/sparsepp
# https://github.com/COMBINE-lab/RapMap , actually runs curl to fetch it
# https://github.com/Kingsford-Group/libgff
# sci-libs/io_lib
#
# https://github.com/COMBINE-lab/salmon/issues/19#issuecomment-144721158
# modified bwa copy
#
# and maybe more

# See https://github.com/COMBINE-lab/salmon/issues/236 for Cmake tweaks needed by Debian
src_configure(){
	local mycmakeargs=(
		"-DBOOST_INCLUDEDIR=${EPREFIX}/usr/include/boost/"
		"-DBOOST_LIBRARYDIR=${EPREFIX}/usr/$(get_libdir)/"
		"-DTBB_INSTALL_DIR=${EPREFIX}/usr"
		"-DCMAKE_INSTALL_PREFIX=${EPREFIX}/usr"
	)
	# BUG: the configure step runs automatically curl download of 3rd-party stuff
	# https://github.com/COMBINE-lab/salmon/issues/19
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	rm -r "${ED}"/usr/tests || die
}
