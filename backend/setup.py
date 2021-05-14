"""Build and install the cipher demo package."""

from setuptools import setup, find_packages

with open("README.rst", "r") as fh:
    long_description = fh.read()

with open("version", "r") as fh:
    version = fh.read()


setup(
    name='FoodFinder',
    install_requires=[
        "django",
        "numpy"
    ],
    version=version,
    description='Food Finder Demonstartion for Software Engineering.',
    long_description=long_description,
    url='https://github.com/SWES21/myRepo',
    download_url='https://github.com/SWES21/myRepo',
    author='CSDS 393 Group #30',
    author_email='fms34@case.edu',
    maintainer='CSDS 393 Team #30',
    maintainer_email='fms34@case.edu',
    classifiers=[
        "Natural Language :: English",
        "Operating System :: OS Independent",
        "Programming Language :: Python :: 3 :: Only",
        "Programming Language :: Python :: 3.9",
        "Topic :: SoftwareEngineering :: Application",
    ],
    package_dir={"": "food_finder"},
    packages=find_packages('food_finder'),
)
