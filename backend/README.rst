#########################
[foodfinder_demo] Package
#########################

Food finder demonstration for CSDS 393.


***********
Quick Start
***********

First, install this package locally using either a Pip editable install (``py -3 -m pip install -e .``) or by using
``setup.py`` (i.e., ``py -3 setup.py install``). If developing this package as a team member, use the former command.
However, if you are a TA or grader, the latter command will suffice.

Then, launch the GUI from the command line::

    $ py -3 -m cipher_demo.gui


***********
Development
***********

Norms
=====

* Branches should be named using the following convention: ``<username>/<feature-name>``

* When delivering a feature to master, the ``version`` file shall be incremented in accordance with `semantic versioning
  <https://semver.org/>`_ and a corresponding entry shall be added to ``docs/release_notes.rst``.

* The team shall leverage GitHub pull requests and code reviews to facilitate delivery. Reviews should have 2 reviewers.

* Branches shall be deleted when merged.

* Pull requests shall be squashed to maintain a clean history on the master branch.

Running Tests Locally
=====================

Unit testing, static analysis, and documentation generation leverage the ``tox`` package. The following commands are
useful for locally verifying code functionality and styling::

    $ py -3 -m tox -e py3  # run tests
    $ py -3 -m tox -e pylint  # static analysis with Pylint
    $ py -3 -m tox -e pycodestyle  # check conformance to PEP 8
    $ py -3 -m tox -e pydocstyle  # check conformance to PEP 257
    $ py -3 -m tox -e docs  # render package documentation as HTML
