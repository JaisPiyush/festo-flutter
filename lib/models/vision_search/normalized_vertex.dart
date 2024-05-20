class NormalizedVertex {
  final double x;
  final double y;

  const NormalizedVertex({required this.x, required this.y});

  NormalizedVertex.fromJson(Map<String, dynamic> json)
      : x = double.parse(json['x']),
        y = double.parse(json['y']);

  Map<String, dynamic> toJson() => {'x': x, 'y': y};
}

class BoundingPoly {
  final List<NormalizedVertex> normalized_vertices;

  const BoundingPoly(this.normalized_vertices);

  BoundingPoly.fromJson(Map<String, dynamic> json)
      : normalized_vertices = (json['normalized_vertices'] as List<dynamic>)
            .map((e) => NormalizedVertex.fromJson(e as Map<String, dynamic>))
            .toList();
  Map<String, dynamic> toJson() {
    return {
      'normalized_vertices': normalized_vertices.map((e) => e.toJson()).toList()
    };
  }
}
