With Dropshadow without prefix.
```lua
TextLabel({
			Size = UDim2.fromScale(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Text = "Vide",
			StrokeThickness = 2,
			DropShadow = {
				Offset = UDim2.fromScale(0, 0.02),
			},
		}),
```
Without Dropshadow with prefix.
TextLabel({
			Size = UDim2.fromScale(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Text = "Vide",
			StrokeThickness = 2,
      Prefix = {
				Image = ImageIds.Backpack,
				ImageScale = 0.5,
				Padding = UDim.new(0, 0),
			},
		}),
