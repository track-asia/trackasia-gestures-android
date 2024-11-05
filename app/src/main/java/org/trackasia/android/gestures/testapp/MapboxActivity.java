package org.trackasia.android.gestures.testapp;

import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import org.trackasia.android.TrackAsia;
import org.trackasia.android.maps.TrackAsiaMap;
import org.trackasia.android.maps.MapView;
import org.trackasia.android.maps.OnMapReadyCallback;

/**
 * Test activity showcasing a simple MapView with current mapbox-gestures-android library commit.
 */
public class MapboxActivity extends AppCompatActivity implements OnMapReadyCallback {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    TrackAsia.getInstance(this);

    setContentView(R.layout.activity_mapbox);
    MapView mapView = findViewById(R.id.map_view);
    mapView.getMapAsync(this);
  }

  @Override
  public void onMapReady(@NonNull TrackAsiaMap trackAsiaMap) {
    trackAsiaMap.setStyle("https://tiles.track-asia.com/tiles/v1/style-streets.json?key=public");
  }
}
