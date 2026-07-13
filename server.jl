using HTTP

#http://localhost:8000/

const ROOT = pwd()

function mime(path)
    ext = lowercase(splitext(path)[2])
    Dict(
        ".html" => "text/html",
        ".js"   => "application/javascript",
        ".css"  => "text/css",
        ".json" => "application/json",
        ".png"  => "image/png",
        ".jpg"  => "image/jpeg",
        ".svg"  => "image/svg+xml",
        ".ico"  => "image/x-icon",
		".mp4"  => "video/mp4"
    )[ext]
end

HTTP.serve("0.0.0.0", 8000) do req
	path = joinpath(ROOT, isempty(req.target) || req.target == "/" ? "index.html" : req.target[2:end])
	if isfile(path)
	   return HTTP.Response(200,["Content-Type" => mime(path)],read(path))
	else
	   return HTTP.Response(404, "404 not found")
	end
end