-- Renders a bead with the desired color and position
function bead(pos,color,label)
	fontcolor = "bg"
    drawcolor = color
    if (color == "bg") then
    	fontcolor = "fg"
    	drawcolor = "fg"
    elseif (color == "lime") then
    	fontcolor = "fg"
    end
	tex.sprint("\\path (C) ++" .. pos .. "node[circle,fill=bg,inner sep=0pt,minimum size=1.7cm] {};");
	tex.sprint("\\path (C) ++" .. pos .. "node[fill=" .. color .. ",draw=".. drawcolor ..",circle,inner sep=0pt,minimum size=1.5cm, text=".. fontcolor .."] {".. label .."};");
end

-- Given a string of colors, render a bracelet with 
-- those colors. First one apears at 12 o'clock
-- the rest follow clockwise
function bracelet(inputstr, num)
	num = (num ~= nill)
	tex.sprint("\\node (C) at (0,0){};");
	tex.sprint("\\draw (0,0) circle (3cm);");
	beads = split(inputstr);
    n = #beads;
    for k,v in pairs(beads) do
    	-- This looks so bizarre cause lua indexes at 1
        -- and tikz starts 0 deg at 3 o'clock and goes
        -- counter clockwise.
    	bead("(" .. (90 + (((1-k)*360)/n)) .. ":3cm)",parseColor(v),parseLabel(k,num));
    end
end


function parseLabel(label, p)
	if p then
    	return ("\\Huge " .. label)
    else
    	return ""
    end 
end
-- Black and White should render out to the 
-- background and foreground color of the 
-- beamer theme respectively. 
function parseColor(color)
	if (color == "black") then
    	return "fg"
    elseif (color == "white") then
    	return "bg"
    else
    	return color
    end
end

-- Lua Doesn't have a built in split command for some reason
-- Takes a string and a separation character and splits the
-- into an array at the separation characters.
-- no separation character will cause the string to be split
-- on white space
function split(inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={} ; i=1
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                t[i] = str
                i = i + 1
        end
        return t
end