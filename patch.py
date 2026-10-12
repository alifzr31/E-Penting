import sys

with open('lib/app/widgets/base_checkboxgroupfield.dart', 'r') as f:
    lines = f.readlines()

out = []
in_wrap = False
for i, line in enumerate(lines):
    if 'double runSpacing = 8.0,' in line:
        out.append(line)
        out.append('    int? crossAxisCount,\n')
        continue
    
    if 'Wrap(' in line and 'children: items.map' not in line:
        # found the start of wrap
        in_wrap = True
        out.append('''                 LayoutBuilder(
                   builder: (context, constraints) {
                     final double? itemWidth = crossAxisCount != null
                         ? (constraints.maxWidth - (spacing * (crossAxisCount - 1))) / crossAxisCount!
                         : null;

                     return Wrap(
                       spacing: spacing,
                       runSpacing: runSpacing,
                       children: items.map((item) {
                         final isSelected = selectedItems.contains(item);

                         Widget buttonChild = Row(
                           mainAxisSize: .min,
                           children: [
                             Icon(
                               isSelected
                                   ? RemixIcon.checkboxFill
                                   : RemixIcon.checkboxBlankLine,
                               size: 20,
                               color: AppColors.blueColor,
                             ),
                             const SizedBox(width: 4),
                             Flexible(
                               child: Text(
                                 itemLabelBuilder(item),
                                 style: TextStyle(
                                   fontSize: 14,
                                   fontWeight: isSelected
                                       ? FontWeight.w500
                                       : FontWeight.w400,
                                   color: Colors.black,
                                   fontFamily: 'Poppins',
                                 ),
                                 maxLines: 1,
                                 overflow: TextOverflow.ellipsis,
                               ),
                             ),
                           ],
                         );

                         Widget button = CupertinoButton(
                           alignment: .centerLeft,
                           minimumSize: .zero,
                           padding: const EdgeInsets.all(2),
                           onPressed: readOnly
                               ? null
                               : () {
                                   final newItems = List<T>.from(selectedItems);
                                   if (isSelected) {
                                     newItems.remove(item);
                                   } else {
                                     newItems.add(item);
                                   }

                                   state.didChange(newItems);
                                   if (onChanged != null) {
                                     onChanged(newItems);
                                   }
                                 },
                           child: buttonChild,
                         );

                         if (itemWidth != null) {
                           return SizedBox(width: itemWidth, child: button);
                         }
                         return button;
                       }).toList(),
                     );
                   },
                 ),
''')
        continue
        
    if in_wrap:
        if 'if (hasError) ...[' in line:
            in_wrap = False
            out.append(line)
        continue
        
    if not in_wrap:
        out.append(line)

with open('lib/app/widgets/base_checkboxgroupfield.dart', 'w') as f:
    f.writelines(out)
