import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:new_flutter/models/grocery_manager.dart';
import 'package:uuid/uuid.dart';
import '../components/grocery_tile.dart';
import '../models/models.dart';

class GroceryItemScreen extends StatefulWidget {
  static page({
    Key? key,
    GroceryItem? item,
    int index = -1,
    required Function(GroceryItem) onCreate,
    required Function(GroceryItem, int) onUpdate,
  }) {
    return MaterialPage<void>(
      name: '/item',
      key: const ValueKey('/item'),
      child: GroceryItemScreen(
        originalItem: item,
        index: index,
        oncreate: onCreate,
        onUpdate: onUpdate,
      ),
    );
  }

  const GroceryItemScreen({
    Key? key,
    required this.oncreate,
    required this.onUpdate,
    this.originalItem,
  })  :
        super(key: key);

  final Function(GroceryItem) oncreate;
  final Function(GroceryItem, int) onUpdate;
  final GroceryItem? originalItem;


  @override
  State<GroceryItemScreen> createState() => _GroceryItemScreenState();
}

class _GroceryItemScreenState extends State<GroceryItemScreen> {
  final _nameController = TextEditingController();
  String _name = '';
  Importance _importance = Importance.low;
  DateTime _dueDate = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();
  Color _currentColor = Colors.green;
  int _currentSliderValue = 0;

  @override
  void initState() {
    final originalItem = widget.originalItem;
    if (originalItem != null) {
      _nameController.text = originalItem.name;
      _name = originalItem.name;
      _currentSliderValue = originalItem.quantity;
      _importance = originalItem.importance;
      _currentColor = originalItem.color;
      final date = originalItem.date;
      _timeOfDay = TimeOfDay(hour: date.hour, minute: date.minute);
      _dueDate = date;
    }
    _nameController.addListener(() {
      setState(() {
        _name = _nameController.text;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              final groceryItem = GroceryItem(
                id: widget.originalItem?.id ?? const Uuid().v1(),
                name: _nameController.text,
                importance: _importance,
                color: _currentColor,
                quantity: _currentSliderValue,
                date: DateTime(
                  _dueDate.year,
                  _dueDate.month,
                  _dueDate.day,
                  _timeOfDay.hour,
                  _timeOfDay.minute,
                ),
              );
              
                widget.onUpdate(groceryItem);
             
              GoRouter.of(context).pop();
            },
            icon: const Icon(Icons.check),
          )
        ],
        title: Text(
          'Grocery Item',
          style: GoogleFonts.robotoFlex(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
        child: ListView(
          children: [
            _buildNameField(
              'Item Name',
              'E.g. Apples, banana, 1 Bag of salt',
            ),
            const SizedBox(height: 12),
            Text(
              'Importance',
              style: GoogleFonts.robotoFlex(
                  fontSize: 19, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Wrap(
                  spacing: 10.0,
                  children: [
                    _buildImportanceField('Low', Importance.low),
                    _buildImportanceField('Medium', Importance.medium),
                    _buildImportanceField('High', Importance.high),
                  ],
                )
              ],
            ),
            _buildDateField(context),
            const SizedBox(height: 12),
            buildTimeField(context),
            const SizedBox(height: 12),
            buildColorPicker(context),
            const SizedBox(height: 12),
            buildQuantityField(),
            const SizedBox(height: 12),
            GroceryTile(
              item: GroceryItem(
                id: 'PreviewMode',
                name: _name,
                importance: _importance,
                color: _currentColor,
                quantity: _currentSliderValue,
                date: DateTime(
                  _dueDate.year,
                  _dueDate.month,
                  _dueDate.day,
                  _timeOfDay.hour,
                  _timeOfDay.minute,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNameField(String text, String hinttext) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: GoogleFonts.robotoFlex(
              fontSize: 19.0, fontWeight: FontWeight.w600),
        ),
        TextField(
          controller: _nameController,
          cursorColor: _currentColor,
          decoration: InputDecoration(
              hintText: hinttext,
              hintStyle: const TextStyle(fontSize: 17),
              border: const UnderlineInputBorder(
                borderSide: BorderSide(
                    width: double.infinity,
                    color: Color(0xFFC6C6C8),
                    style: BorderStyle.solid),
              ),
              suffixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.cancel_rounded,
                ),
                iconSize: 20,
              )),
        ),
      ],
    );
  }

  Widget _buildImportanceField(String text, Importance importance) {
    return ChoiceChip(
      selectedColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      label: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
      selected: _importance == importance,
      onSelected: (selected) {
        setState(() {
          _importance = importance;
        });
      },
    );
  }

  Widget _buildDateField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Date',
              style: GoogleFonts.robotoFlex(
                  fontSize: 19.0, fontWeight: FontWeight.w600),
            ),
            TextButton(
                onPressed: () async {
                  final currentDate = DateTime.now();
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: currentDate,
                    firstDate: currentDate,
                    lastDate: DateTime(currentDate.year + 5),
                  );
                  setState(() {
                    if (selectedDate != null) {
                      _dueDate = selectedDate;
                    }
                  });
                },
                child: const Text('Select'))
          ],
        ),
        Text('${DateFormat('yyyy-MM-dd').format(_dueDate)}'),
      ],
    );
  }

  Widget buildTimeField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Time of Day',
              style: GoogleFonts.robotoFlex(
                  fontSize: 19, fontWeight: FontWeight.w600),
            ),
            TextButton(
              child: const Text('Select'),
              onPressed: () async {
                // 1
                final timeOfDay = await showTimePicker(
                  // 2
                  initialTime: TimeOfDay.now(),
                  context: context,
                );
                // 3
                setState(() {
                  if (timeOfDay != null) {
                    _timeOfDay = timeOfDay;
                  }
                });
              },
            ),
          ],
        ),
        Text('${_timeOfDay.format(context)}'),
      ],
    );
  }

  Widget buildColorPicker(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              height: 50,
              width: 10,
              color: _currentColor,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              'Color',
              style: GoogleFonts.robotoFlex(
                fontSize: 19,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        TextButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: BlockPicker(
                        pickerColor: Colors.white,
                        onColorChanged: (color) {
                          setState(() => _currentColor = color);
                        },
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('save'))
                      ],
                    );
                  });
            },
            child: const Text('Select'))
      ],
    );
  }

  Widget buildQuantityField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              'Quantity',
              style: GoogleFonts.robotoFlex(
                  fontSize: 19, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              width: 16,
            ),
            Text(
              _currentSliderValue.toInt().toString(),
              style: GoogleFonts.robotoFlex(
                  fontSize: 17, fontWeight: FontWeight.w400),
            )
          ],
        ),
        Slider(
            inactiveColor: _currentColor.withOpacity(0.5),
            activeColor: _currentColor,
            min: 0.0,
            max: 100.0,
            divisions: 100,
            value: _currentSliderValue.toDouble(),
            onChanged: (double value) {
              setState(() {
                _currentSliderValue = value.toInt();
              });
            })
      ],
    );
  }
}
