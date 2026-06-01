// lib/widgets/temas_gridview.dart

import 'package:flutter/material.dart';
import '../models/tema_item.dart';

class TemasGridView extends StatelessWidget {
  const TemasGridView({super.key, required this.temas, this.onTap});

  final List<TemaItem> temas;
  final void Function(TemaItem)? onTap;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      crossAxisCount: 3,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 0.95,
      children: <Widget>[
        for (final TemaItem tema in temas)
          GestureDetector(
            onTap: () => onTap?.call(tema),
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black12),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    tema.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Container(color: tema.cor.withValues(alpha: 0.85)),
                  ),
                  Container(color: tema.cor.withValues(alpha: 0.45)),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: Text(
                        tema.nome,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}