
module Make(Ord: Map.OrderedType): (Amap.S with type key = Ord.t) = struct
	module OMap = Map.Make(Ord)
    type key = Ord.t
	type 'a t = {mutable contents : 'a OMap.t}
	


let empty () = {contents = OMap.empty}
	
let update m key init update =
	let value = try update (OMap.find key m.contents ) with Not_found -> init () in
	m.contents <- (OMap.add  key value m.contents);
	value
	
	
let find_or_add m key init =
	let value = try OMap.find key  m.contents 
				with Not_found ->
					let value = init () in
					m.contents <- (OMap.add  key value m.contents);
					value
	in
	value

let find m key =
	OMap.find key m.contents
	
let find_save = find
	
let add_or_replace m key v =
	m.contents <- (OMap.add key v m.contents) 
	
let iter f m =
	OMap.iter f m.contents
	
let fold f acc m =
	OMap.fold f  m.contents acc
	

	
end

module Int = Make (struct  type t = int 
	let compare = compare
end)