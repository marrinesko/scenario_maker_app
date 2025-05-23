// scenario_item.dart
// Виджет для отображения одного элемента списка сценариев
import 'package:flutter/material.dart';
import 'package:scenario_maker_app/models/scenario_result_model.dart';

class ScenarioItem extends StatefulWidget {
  final ScenarioResultModel scenario; // Данные сценария
  final VoidCallback? onShare; // Коллбек для шаринга
  final VoidCallback? onDelete; // Коллбек для удаления

  const ScenarioItem({
    super.key,
    required this.scenario,
    this.onShare,
    this.onDelete,
  });

  @override
  State<ScenarioItem> createState() => _ScenarioItemState();
}

class _ScenarioItemState extends State<ScenarioItem> {
  bool _isExpanded = false; // Флаг раскрытия подробностей

  @override
  Widget build(BuildContext context) {
    return Card(
      // Оформление карточки
      color: Colors.white,
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.scenario.title, // Заголовок сценария
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  onPressed: () => setState(() => _isExpanded = !_isExpanded),
                  icon: Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            AnimatedCrossFade(
              firstChild: Text(
                widget.scenario.body, // Краткий превью текста
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
              secondChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.scenario.body,
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  const Divider(color: Colors.grey, thickness: 0.8),
                  const SizedBox(height: 8),
                  _buildDetailRow(
                    'Платформа',
                    widget.scenario.request.platform.name,
                  ), // Платформа
                  _buildDetailRow('Тема', widget.scenario.request.videoTheme),
                  _buildDetailRow('ЦА', widget.scenario.request.targetAudience),
                  _buildDetailRow(
                    'Призыв',
                    widget.scenario.request.callToAction,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: widget.onShare,
                        icon: const Icon(Icons.share, color: Colors.blue),
                      ),
                      IconButton(
                        onPressed: widget.onDelete,
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
              crossFadeState:
                  _isExpanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            ),
          ],
        ),
      ),
    );
  }

  // Вспомогательный ряд для детализации
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
