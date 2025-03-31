#!/bin/bash
#

module purge
module load gcc
module load cmake

if false; then
    module load openmpi/4.1.5-gcc
else
    module load openmpi-debug
fi
export MOSE_ROOT="${HOME}/mpi_offload"

build_dir="$( pwd )/build"
if [ ! -d "${build_dir}" ]; then mkdir "${build_dir}"; fi

install_dir="$( pwd )/install"

cmake \
   -D CMAKE_INSTALL_PREFIX=${install_dir} \
   -D CMAKE_C_COMPILER=gcc \
   -D CMAKE_CXX_COMPILER=g++ \
   -D CMAKE_Fortran_COMPILER=gfortran \
   -D CMAKE_BUILD_TYPE=Debug \
   -D BUILD_MPI=yes \
   -D BUILD_OMP=yes \
   -D BUILD_SHARED_LIBS=yes \
   -D LAMMPS_MACHINE=mpi \
   -S ./cmake -B ${build_dir} $*

cmake --build ${build_dir} -j 8

