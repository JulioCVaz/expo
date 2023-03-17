import { Image } from 'expo-image';
import * as React from 'react';
import { StyleSheet, View } from 'react-native';

import { Colors } from '../../constants';

// A blurhash of https://picsum.photos/seed/175/300/200 with 6x4 components
const blurhash = 'WgF}G?az0fs.x[jat7xFRjNHt6s.4;oe-:RkVtkCi^Nbo|xZRjWB';

export default function ImageBlurhashScreen() {
  const imageViewRef = React.useRef<Image>(null);

  const onImageLoad = React.useCallback(async () => {
    setTimeout(() => {
      imageViewRef.current?.clearContent();
    }, 1000);
  }, [imageViewRef]);

  return (
    <View style={styles.container}>
      <Image
        ref={imageViewRef}
        style={styles.image}
        source={{ uri: 'https://picsum.photos/seed/175/3000/2000' }}
        placeholder={{ blurhash, width: 18, height: 12 }}
        transition={1000}
        contentFit="cover"
        cachePolicy="none"
        onLoad={onImageLoad}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20,
  },
  image: {
    height: 200,
    borderWidth: 1,
    borderColor: Colors.border,
  },
});
