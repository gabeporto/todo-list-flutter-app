import 'package:flutter/material.dart';

Row detailRow({String label = '', String value = ''}){
  return Row(
    children: [
      Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
      Expanded(
        child: Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  );
}