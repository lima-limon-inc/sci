# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} )

inherit distutils-r1

DESCRIPTION="Python bindings for ERFA"
HOMEPAGE="https://github.com/liberfa/pyerfa/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# ImportError: cannot import name 'ufunc' from 'erfa'
RESTRICT="test"

RDEPEND="
	sci-astronomy/erfa:0=
	dev-python/numpy[${PYTHON_USEDEP}]
"
BDEPEND="${RDEPEND}
	dev-python/setuptools_scm[${PYTHON_USEDEP}]
	test? (
		dev-python/pytest-doctestplus[${PYTHON_USEDEP}]
	)"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-astropy