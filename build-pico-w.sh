sudo apt-get install gcc-arm-none-eabi libstdc++-arm-none-eabi-newlib

rm -f firmware_*.uf2

SKIP_CLEAN=N

function build() {
  BOARD_NAME=$1
  echo building \
    && make -C mpy-cross -j 1 \
    && cd ports/rp2 \
    && if [ $SKIP_CLEAN = Y ]; then echo skip clean; else make BOARD=$BOARD_NAME clean; fi \
    && make submodules BOARD=$BOARD_NAME \
    && make \
          USER_C_MODULES=../../lib/st7789_mpy/st7789/micropython.cmake \
          BOARD=$BOARD_NAME \
          FROZEN_MANIFEST=../boards/$BOARD_NAME/manifest.py \
          V=1 \
          -j 8 \
    && cd ../.. \
    && cp -a ports/rp2/build-$BOARD_NAME/firmware.uf2 firmware_$BOARD_NAME.uf2 \
    && echo SUCCESS
}

build "RPI_PICO_W"
