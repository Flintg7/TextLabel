--!nocheck
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local vide = require(ReplicatedStorage.Packages.vide)

type Props = {
	ApplyStrokeMode: Enum.ApplyStrokeMode,
	Thickness: number,
	Color: Color3,
	Transparency: number,
}

return function(props: Props)
	return vide.create("UIStroke", {
		ApplyStrokeMode = props.ApplyStrokeMode or Enum.ApplyStrokeMode.Contextual,
		Thickness = props.Thickness or 1,
		Color = props.Color or Color3.new(0, 0, 0),
		Transparency = props.Transparency or 0,
	})
end
