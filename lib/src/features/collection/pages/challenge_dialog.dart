import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../game/repository/game_repository.dart';


enum ChallengeMode { enter, create }

class ChallengeDialog extends StatefulWidget {
  const ChallengeDialog({required this.startGameCallback, super.key});

  final Function(String) startGameCallback;

  @override
  State<ChallengeDialog> createState() => _ChallengeDialogState();
}

class _ChallengeDialogState extends State<ChallengeDialog> {
  final _formKey = GlobalKey<FormState>();
  String? _gameId;
  ChallengeMode _selectedSegment = ChallengeMode.enter;

  void _startGame() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState!.save();
      context.pop();
      widget.startGameCallback(_gameId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      title: const Text('Challenge Friends'),
      content: AnimatedSize(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Play with a friend by creating a new game PIN or entering an existing one.',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            SegmentedButton<ChallengeMode>(
              segments: const [
                ButtonSegment(
                  value: ChallengeMode.enter,
                  label: Text('Enter PIN'),
                  icon: Icon(Icons.login),
                ),
                ButtonSegment(
                  value: ChallengeMode.create,
                  label: Text('Create PIN'),
                  icon: Icon(Icons.add),
                ),
              ],
              selected: {_selectedSegment},
              onSelectionChanged: (newSelection) {
                setState(() {
                  _selectedSegment = newSelection.first;
                });
              },
            ),
            const SizedBox(height: 24),
            if (_selectedSegment == ChallengeMode.create) _buildCreatePinView(),
            if (_selectedSegment == ChallengeMode.enter) _buildEnterPinView(),
          ],
        ),
      ),
    );
  }

  Widget _buildCreatePinView() {
    if (_gameId == null) {
      return ElevatedButton.icon(
        onPressed: () {
          setState(() {
            _gameId = GameRepository.newGameId;
          });
        },
        icon: const Icon(Icons.casino),
        label: const Text('Generate Game PIN'),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Your Game PIN is:'),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Theme.of(
              context,
            ).colorScheme.surfaceContainerHighest.withAlpha(100),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withAlpha(150),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _gameId!,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.copy),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: _gameId!));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('PIN copied to clipboard!')),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            context.pop();
            widget.startGameCallback(_gameId!);
          },
          child: const Text('Start Game'),
        ),
      ],
    );
  }

  Widget _buildEnterPinView() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Game PIN',
              hintText: 'Enter the 8-digit PIN',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.pin),
            ),
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
            validator: (value) {
              if (value == null || value.length != 8) {
                return 'Please enter a valid 8-digit PIN.';
              }
              return null;
            },
            onSaved: (value) {
              _gameId = value;
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _startGame,
            child: const Text('Start Game'),
          ),
        ],
      ),
    );
  }
}
