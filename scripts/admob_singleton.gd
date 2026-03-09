extends Node

signal interstitial_loaded
signal rewarded_video_loaded
signal rewarded

func _ready():
    pass

func init(is_real := true, instance_id := 0):
    # In a real plugin, this would initialize the AdMob SDK.
    print("AdMob Singleton: Initializing...")

func load_interstitial(ad_id: String):
    print("AdMob Singleton: Loading interstitial ad with ID: ", ad_id)
    # This is a placeholder. A real plugin would make a native call.
    # We emit the signal here to simulate a successful load for testing purposes.
    emit_signal("interstitial_loaded")

func show_interstitial():
    print("AdMob Singleton: Showing interstitial ad.")
    # In a real plugin, this would display the ad.

func load_rewarded_video(ad_id: String):
    print("AdMob Singleton: Loading rewarded video with ID: ", ad_id)
    # This is a placeholder. A real plugin would make a native call.
    # We emit the signal here to simulate a successful load for testing purposes.
    emit_signal("rewarded_video_loaded")

func show_rewarded_video():
    print("AdMob Singleton: Showing rewarded video.")
    # In a real plugin, this would display the ad and handle the reward.
    # For simulation purposes, we emit the reward signal directly.
    emit_signal("rewarded", "reward_type", 100)
