sudo apt-get install gcc-arm-none-eabi libstdc++-arm-none-eabi-newlib

git clean -f -d -X

rm -f firmware.uf2

echo building \
  && make -C mpy-cross -j 1 \
  && cd ports/rp2 \
  && make BOARD=RPI_PICO_W clean \
  && make submodules BOARD=RPI_PICO_W \
  && make \
        USER_C_MODULES=../../lib/st7789_mpy/st7789/micropython.cmake \
        BOARD=RPI_PICO_W \
        FROZEN_MANIFEST=../boards/RPI_PICO_W/manifest.py \
        V=1 \
        -j 8 \
  && cd ../.. \
  && cp -a ports/rp2/build-RPI_PICO_W/firmware.uf2 . \
  && echo SUCCESS
